Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8E91EA73
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Oct 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508433; cv=none; b=NDNHaTGEcrmV9/i+FUFXeyTsanpfpZvkGGjKFvpV2ga1cdyfS8HhsXfs3cIe5kBf1d8yu2mJ8aoKKi4oMPATCmbKajPFAYJRA/fQMhpA0GLVB46OTF+rgGZ1OBsxzgXp1wo6MQq0wGHWlGEMZqEUBSKHUhwUL0P0eSC7xBMLV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508433; c=relaxed/simple;
	bh=I97oXrR2A+o/p0R2T6cLh15jONBj/8LUwZoLk0HQxRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqLq5aziU4pGlq7MWyS+Cpkbkf6Anrx4fYgfXiv8RqRi8dOunwOGRLvHXnUPO77VSVwOjSoCKFkOdFKeg4IUQzlf3y+hl+1BUuSOImDYFjImggHzzZwHWxgQcir6LOXmsCD79vz8KZ1TKdOHaN673+XAflNN9KLBfPzz80nkwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAAE9DA7;
	Wed,  9 Oct 2024 14:14:18 -0700 (PDT)
Received: from [10.57.22.175] (unknown [10.57.22.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F0F13F64C;
	Wed,  9 Oct 2024 14:13:47 -0700 (PDT)
Message-ID: <e3542d05-9bc3-45f7-98af-73be9db27359@arm.com>
Date: Wed, 9 Oct 2024 22:13:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/4] Add dso__is_pie call to identify ELF PIE
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <18bb5281c3648a67bff61ce44966d3dfd7c09b4f.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <18bb5281c3648a67bff61ce44966d3dfd7c09b4f.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2024 10:30 PM, Steve Clevenger wrote:
> 
> Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
> the DF_1_PIE flag. This identifies position executable code.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/symbol-elf.c | 61 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/symbol.h     |  1 +
>  2 files changed, 62 insertions(+)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index e398abfd13a0..babe47976922 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -662,6 +662,67 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>         return err;
>  }
> 
> +/*
> + * Check dynamic section DT_FLAGS_1 for a Position Independent
> + * Executable (PIE).
> + */
> +bool dso__is_pie(struct dso *dso)
> +{
> +       Elf *elf = NULL;
> +       Elf_Scn *scn = NULL;
> +       GElf_Ehdr ehdr;
> +       GElf_Shdr shdr;
> +       bool is_pie = false;
> +       char dso_path[PATH_MAX];
> +       int fd = -1;
> +
> +       if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
> +               goto exit;      // false
> +
> +       dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
> +
> +       fd = open(dso_path, O_RDONLY);
> +
> +       if (fd < 0) {
> +               pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
> +               goto exit;      // false
> +       }
> +
> +       elf = elf_begin(fd, ELF_C_READ, NULL);
> +       gelf_getehdr(elf, &ehdr);
> +
> +       if (ehdr.e_type == ET_DYN) {
> +               Elf_Data *data;
> +               GElf_Dyn *entry;
> +               int n_entries = shdr.sh_size / sizeof(GElf_Dyn);

I took time to play this series on Arm64 machine and found issue in above
sentence. As the 'shdr' strucutre is read out from elf_section_by_name()
below, but it calculates the entries before reading out the section header.
Therefore, I observed that program will not be detected as PIE executable due
to 'n_entries' is 0.

With fixing this bug, then I observed the regression caused by patch 02.

Below are steps:

- Build test program with below command:

  # gcc -pie -Wl,-z,relro,-z,now -o test test.c
  # readelf readelf -a test | grep FLAGS
  0x000000000000001e (FLAGS)              BIND_NOW
  0x000000006ffffffb (FLAGS_1)            Flags: NOW PIE

  The test program is a simple infinite loop. I run this program in a docker
  container with Fedora 40.

- Record trace data:

  # perf record -e cycles -p 149531
  # perf script

            test  149531 483168.078485:       4986 cycles:      aaaacde401b4
[unknown] (/home/test)
            test  149531 483168.078564:     134207 cycles:      aaaacde401b4
[unknown] (/home/test)
            test  149531 483168.079305:    1257097 cycles:      aaaacde401b4
[unknown] (/home/test)

  You can see it fails to parse symbol and print out [unknown].

  After I reverted patch 02 in this series, then:

  # perf script
            test  149531 483168.078485:       4986 cycles:      aaaacde401b4
main+0xc (/home/test)
            test  149531 483168.078564:     134207 cycles:      aaaacde401b4
main+0xc (/home/test)
            test  149531 483168.079305:    1257097 cycles:      aaaacde401b4
main+0xc (/home/test)

Not sure if I miss anything for PIE executable, seems to me, we should drop
the first two patches and just pass pg_off to python script?

Thanks,
Leo

> +
> +               scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
> +               if (!scn)
> +                       goto exit_close;        // false
> +
> +               data = (Elf_Data *) elf_getdata(scn, NULL);
> +               if (!data || !data->d_buf)
> +                       goto exit_close;        // false
> +
> +               // check DT_FLAGS_1
> +               for (int i = 0; i < n_entries; i++) {
> +                       entry = ((GElf_Dyn *) data->d_buf) + i;
> +                       if (entry->d_tag == DT_FLAGS_1) {
> +                               if ((entry->d_un.d_val & DF_1_PIE) != 0) {
> +                                       is_pie = true;
> +                                       break;
> +                               }
> +                       }
> +               } // end for
> +       }
> +
> +exit_close:
> +       elf_end(elf);
> +       close(fd);
> +exit:
> +       return is_pie;
> +}
> +
>  /*
>   * We need to check if we have a .dynsym, so that we can handle the
>   * .plt, synthesizing its symbols, that aren't on the symtabs (be it
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 3fb5d146d9b1..33ea2596ce31 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -127,6 +127,7 @@ void dso__insert_symbol(struct dso *dso,
>                         struct symbol *sym);
>  void dso__delete_symbol(struct dso *dso,
>                         struct symbol *sym);
> +bool dso__is_pie(struct dso *dso);
> 
>  struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
>  struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
> --
> 2.44.0
> 
