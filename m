Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358615749A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877305; cv=none; b=Z0y0L1xqPtJNyreEj3Jy+9rBlmUTE696fU5AQT1hdlYpLOu9e/M3EvcSkksaCy6URRJveh/4cv1xvHW9kQtonB4dwrt+U0IbEEmq93hbZ05f+RCphxTMqUQIQfGDttWh98+SwzAtqA5KMkVCSgGBZEaqrhpMc7Nqatnjr2uaB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877305; c=relaxed/simple;
	bh=xYDhrKHNRNbCm4aNzM4JtnJ3ART2wL+7FTMEmCiN/M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ij0lfpe7caPy4qWjeujByZV63okP0JDqRS5sUn0RHcQdsfFE7tygAMhnUcCLRBRUcd8jjPqEyK6zAYlwpC44mNF49brIa3qvw9iUaPs2V8o00Jj/r0+/Ud7TbUFhLDr5iF1rBmjU9nF4pOH3ABjD3+s4Bk7cpNaoV6EAzYR/0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD192DA7;
	Wed, 28 Aug 2024 13:35:27 -0700 (PDT)
Received: from [192.168.0.8] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF643F66E;
	Wed, 28 Aug 2024 13:34:59 -0700 (PDT)
Message-ID: <fb493d85-2bb1-4275-b22f-701e60d95a81@arm.com>
Date: Wed, 28 Aug 2024 21:34:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/4] Add dso__is_pie call to identify ELF PIE
To: scclevenger@os.amperecomputing.com, james.clark@linaro.org,
 mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
 <ee7a0b4944093db90a589040be39ef3e7e747f63.1724820993.git.scclevenger@os.amperecomputing.com>
 <1a58ddcd-c386-49b5-a540-4369a1f1469b@arm.com>
 <ce98443a-e79d-4f92-b0cf-4e6603928bbc@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ce98443a-e79d-4f92-b0cf-4e6603928bbc@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2024 4:48 PM, Steve Clevenger wrote:
> 
> On 8/28/2024 1:23 AM, Leo Yan wrote:
>> On 8/28/2024 6:09 AM, Steve Clevenger wrote:
>>>
>>> Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
>>> the DF_1_PIE flag. This identifies position executable code.
>>>
>>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>>> ---
>>>  tools/perf/util/symbol-elf.c | 60 ++++++++++++++++++++++++++++++++++++
>>>  tools/perf/util/symbol.h     |  1 +
>>>  2 files changed, 61 insertions(+)
>>>
>>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>>> index e398abfd13a0..0e49c1345a67 100644
>>> --- a/tools/perf/util/symbol-elf.c
>>> +++ b/tools/perf/util/symbol-elf.c
>>> @@ -662,6 +662,66 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>>>         return err;
>>>  }
>>>
>>> +/*
>>> + * Check dynamic section DT_FLAGS_1 for a Position Independent
>>> + * Executable (PIE).
>>> + */
>>> +bool dso__is_pie(struct dso *dso)
>>> +{
>>> +       Elf *elf = NULL;
>>> +       Elf_Scn *scn = NULL;
>>> +       GElf_Ehdr ehdr;
>>> +       GElf_Shdr shdr;
>>> +       bool is_pie = false;
>>> +       char dso_path[PATH_MAX];
>>> +       int fd = -1;
>>> +
>>> +       if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
>>> +               goto exit;      // false
>>> +
>>> +       dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
>>> +
>>> +       fd = open(dso_path, O_RDONLY);
>>> +
>>> +       if (fd < 0) {
>>> +               pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
>>> +               goto exit;      // false
>>> +       }
>>> +
>>> +       elf = elf_begin(fd, ELF_C_READ, NULL);
>>> +       gelf_getehdr(elf, &ehdr);
>>> +
>>> +       if (ehdr.e_type == ET_DYN) {
>>> +               Elf_Data *data;
>>> +               GElf_Dyn *entry;
>>> +               int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
>>> +
>>> +               scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
>>> +               if (!scn)
>>> +                       goto exit;      // false
>>
>> It should goto a new tag (e.g. exit_failed) so can invoke elf_end(elf) and
>> close(fd).
>>
>>> +
>>> +               data = (Elf_Data *) elf_getdata(scn, NULL);
>>> +               if (!data || !data->d_buf)
>>> +                       goto exit;      // false
>>
>> Ditto.
>>
>>> +
>>> +               // check DT_FLAGS_1
>>> +               for (int i = 0; i < n_entries; i++) {
>>> +                       entry = ((GElf_Dyn *) data->d_buf) + i;
>>> +                       if (entry->d_tag == DT_FLAGS_1) {
>>> +                               if ((entry->d_un.d_val & DF_1_PIE) != 0) {
>>> +                                       is_pie = true;
>>> +                                       break;
>>> +                               }
>>> +                       }
>>> +               } // end for
>>> +       }
>>> +
>>
>> Put 'exit_failed' tag at here.
>>
>> With the changes:
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>>
>>> +       elf_end(elf);
>>> +       close(fd);
>>> +exit:
>>> +       return is_pie;
>>> +}
>>> +
> 
> Hi Leo,
> 
> It's been a long time since I've seen goto's used as a rule rather than
> an exception. I see it introduced the problem you've mentioned.

I am not sure if I understand this. In the Linux code, it is quite common to
use goto to handle failure cases (for releasing resources).

> Is it ok to simply update the cover letter (patch 0), and this one (patch 1)
> as V5? If I don't hear from you, I'll resubmit all.

I assume you also need to address patch 03? It is good to send the all patches
in one go, this would be easier for maintainers to pick up the whole series
(e.g. using b4).

Thanks,
Leo
