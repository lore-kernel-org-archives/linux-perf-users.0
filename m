Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315612DD8F
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362098; cv=none; b=i/Bf/k1bXnOn5+0octi+FjJq4TphoUNsFIkALnrnKbQ9lA6pXOE+zfhE4M4uxTKNR1v9UG4L+MotACTO/Wmrmqek0cgcXFU7MR3/tiOo9Z96Kz29eywSuq96v1LX9m/f+AviJnIySNmob+GoS3rN7vFoydgZbFtMeNc9A9EXFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362098; c=relaxed/simple;
	bh=S3dIH7EyPOGlJC/clWwgFyaH/ZgpQtWz+dEBaVM2JQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEJN/iT4rntq4f/NaprJGaVK14LTDDZATEEj5IPBhuHwm0mJUTAHIn7V3lY1SyFQDCBM6jBgYXGrstdPQZF7EIW4mnPDNKsSyDDgsDNu7mq5t+WPSehxvDFJNxPrdVbA6EV2dsMgt/sPDzYIzT+8Lt2Cg9PqBiDEOIiIcAyAutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 601B81FB;
	Mon, 25 Mar 2024 03:22:09 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA8753F7C5;
	Mon, 25 Mar 2024 03:21:34 -0700 (PDT)
Message-ID: <6fc0c346-530f-476f-af2e-4f9d06828b64@arm.com>
Date: Mon, 25 Mar 2024 10:21:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf tools: Only treat files as map files when they
 have the extension .map
To: Ian Rogers <irogers@google.com>,
 Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
 <20240220042957.2022391-3-ChaitanyaS.Prakash@arm.com>
 <CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/02/2024 14:40, Ian Rogers wrote:
> On Mon, Feb 19, 2024 at 8:30 PM Chaitanya S Prakash
> <ChaitanyaS.Prakash@arm.com> wrote:
>>
>> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>>
>> Perf currently treats any file beginning with "/tmp/perf-" as a map
>> file, even when map files always have the extension ".map". This causes
>> the test "perf probe of function from different CU" to fail because it
>> generates a binary with a filename in that format. When the test passes
>> it as an argument to be opened as an elf file, it's parsed as a map file
>> and results in garbage symbol names. Fix this by only considering files
>> ending in ".map" as map files.
>>
>> The above failure is masked if Perf is built with dwarf support. But
>> with NO_DWARF=1, try_to_find_probe_trace_events() is skipped over in
>> convert_to_probe_trace_events() falling into
>> find_probe_trace_events_from_map() which results in the bad map file
>> parse data being consumed and the inability to create the probe event.
>>
>> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>> ---
>>  tools/perf/builtin-script.c | 15 +--------------
>>  tools/perf/util/string.c    | 18 ++++++++++++++++++
>>  tools/perf/util/string2.h   |  1 +
>>  tools/perf/util/symbol.c    |  5 ++++-
>>  4 files changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index b1f57401ff23..c1c38a3df37a 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -48,6 +48,7 @@
>>  #include <errno.h>
>>  #include <inttypes.h>
>>  #include <signal.h>
>> +#include <string2.h>
>>  #include <sys/param.h>
>>  #include <sys/types.h>
>>  #include <sys/stat.h>
>> @@ -3240,20 +3241,6 @@ static struct script_desc *script_desc__findnew(const char *name)
>>         return s;
>>  }
>>
>> -static const char *ends_with(const char *str, const char *suffix)
>> -{
>> -       size_t suffix_len = strlen(suffix);
>> -       const char *p = str;
>> -
>> -       if (strlen(str) > suffix_len) {
>> -               p = str + strlen(str) - suffix_len;
>> -               if (!strncmp(p, suffix, suffix_len))
>> -                       return p;
>> -       }
>> -
>> -       return NULL;
>> -}
>> -
>>  static int read_script_info(struct script_desc *desc, const char *filename)
>>  {
>>         char line[BUFSIZ], *p;
>> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
>> index 116a642ad99d..94c7af70e636 100644
>> --- a/tools/perf/util/string.c
>> +++ b/tools/perf/util/string.c
>> @@ -349,3 +349,21 @@ char *strreplace_chars(char needle, const char *haystack, const char *replace)
>>
>>         return new_s;
>>  }
>> +
>> +/*
>> + * Returns a pointer to the first character of the suffix in str if the string
>> + * ends with suffix, otherwise returns NULL.
>> + */
>> +const char *ends_with(const char *str, const char *suffix)
>> +{
>> +       size_t suffix_len = strlen(suffix);
>> +       const char *p = str;
>> +
>> +       if (strlen(str) > suffix_len) {
>> +               p = str + strlen(str) - suffix_len;
> 
> nit: I know this is just moving code but it seems unnecessary here to
> call "strlen(str)" twice rather than just hold the result in a local
> variable. A reasonable compiler should optimize this away, but it'd be
> better to have the local imo.
> 
>> +               if (!strncmp(p, suffix, suffix_len))
>> +                       return p;
>> +       }
>> +
>> +       return NULL;
>> +}
>> diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
>> index 52cb8ba057c7..0b9d1579a701 100644
>> --- a/tools/perf/util/string2.h
>> +++ b/tools/perf/util/string2.h
>> @@ -40,5 +40,6 @@ char *strdup_esc(const char *str);
>>
>>  unsigned int hex(char c);
>>  char *strreplace_chars(char needle, const char *haystack, const char *replace);
>> +const char *ends_with(const char *str, const char *suffix);
> 
> nit: string2.h is an extension of linux's string.h. The tools copy of
> that is missing functions in the kernel version:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/include/linux/string.h?h=perf-tools-next
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/include/linux/string.h?h=perf-tools-next#n398
> specifically str_has_prefix.
> 
> The naming ends_with makes sense but there is also strstarts and
> str_has_prefix, perhaps str_has_suffix would be the most consistent
> and intention revealing name?
> 
> Also, we have strtailcmp which behaves like a reverse strcmp that
> doesn't compare the lengths of the strings. It seems all uses of
> strtailcmp are just for a "str_has_suffix". It would make sense to me
> to remove that function and switch to a common str_has_suffix function
> which I think is a more intention revealing way of naming what the
> code is doing.
> 

I glossed over this before, but looking in more detail I couldn't see
that strtailcmp() was definitely being used as str_has_suffix(). Was it
done this way because either the created probe or the dwarf entry could
be using the tail as the filename, but it's not always known which is which?

I couldn't see that function being hit in any of the tests either, so it
seems quite risky to change it and it doesn't cost anything to leave it
as it is seeing as it is a function that does something different to
str_has_suffix().
