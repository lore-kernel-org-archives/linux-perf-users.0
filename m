Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387CEB67A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833446; cv=none; b=GhcZNzRiQ3AHeJpZ9v0T+U+R2Waz6ymYzhqEvNQu5VsNP6fnHS8ds1pN2No46X3Sha1IGvjz5ZGQZbQJflJGGnuMFhqnegnUJjtqcD/vWzjqRxVH2ko9wTcUB0X7OfBnMCrYFLDx1nZqotzNGBPrkCTlFtMk4sD1dLabjbvQ3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833446; c=relaxed/simple;
	bh=ZGBp25SDYNuW4ALFeRCzt+KVjgolVsO1guLDZZ8yodU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuRS3ffYJu3ayECFI6n5NThfj0Dy8aT6Mh/WokGA6siiH23EDK2GKV/M56l/x2LSbutV8OS+p4lzL1FxeVLd3rXZ90bin+ec5HSro0+fmTsqfVKhkWUXYOxUmXgbhgx5Y9RHsMr2W3LInFy1oOZSDP+mUwiBgabPstIao33pLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B017CDA7;
	Wed, 28 Aug 2024 01:24:28 -0700 (PDT)
Received: from [10.1.33.31] (PF4Q20KV.arm.com [10.1.33.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 539983F762;
	Wed, 28 Aug 2024 01:24:01 -0700 (PDT)
Message-ID: <1a58ddcd-c386-49b5-a540-4369a1f1469b@arm.com>
Date: Wed, 28 Aug 2024 09:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/4] Add dso__is_pie call to identify ELF PIE
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
 <ee7a0b4944093db90a589040be39ef3e7e747f63.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ee7a0b4944093db90a589040be39ef3e7e747f63.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2024 6:09 AM, Steve Clevenger wrote:
> 
> Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
> the DF_1_PIE flag. This identifies position executable code.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> ---
>  tools/perf/util/symbol-elf.c | 60 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/symbol.h     |  1 +
>  2 files changed, 61 insertions(+)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index e398abfd13a0..0e49c1345a67 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -662,6 +662,66 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
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
> +
> +               scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
> +               if (!scn)
> +                       goto exit;      // false

It should goto a new tag (e.g. exit_failed) so can invoke elf_end(elf) and
close(fd).

> +
> +               data = (Elf_Data *) elf_getdata(scn, NULL);
> +               if (!data || !data->d_buf)
> +                       goto exit;      // false

Ditto.

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

Put 'exit_failed' tag at here.

With the changes:

Reviewed-by: Leo Yan <leo.yan@arm.com>

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
> 2.25.1
> 
