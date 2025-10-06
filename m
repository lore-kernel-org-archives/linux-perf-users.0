Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169592376EB
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775336; cv=none; b=LiUg3VoEvIhaDYlX7klVpuVt0IL4AHn+kpzh8aFjmDgf689pJw/VrD9NOQ+w2GHL+CDI7DAjanbOXiTanSCpvFFygv0SyFvJZ+FSMYPgrAJBTCaXmSNQBz6T2d5nqwRknMFUjq7dzefPulGAICYYjJLHLiR7ev8oeGpOygQZ5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775336; c=relaxed/simple;
	bh=LLhxi1pE6+D27NtlCHOPs+bATa2iPrAo9FnC74gI0lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/j9L7fe6C9WxjR4BY+Lgbowmc2a1zH/nMAwrR8Chw8x9AuIPqnrdKI4R7HOGXq4SSMR9yUI+XnWXw9CrWSC2L/oewRGlcUUgZIwX5cJsMc7o4dLKzj41hRWHHLTn5ze73Ebiy4slplzo6dbkxK5YY5aAtDCD13cYtxnlbBcV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAu2SvmZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAu2SvmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759775333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2132KzKlEg7eZJV1T1X/BFB3ZV+a5iyDQTo1o0ZTuYk=;
	b=dAu2SvmZmVq3sN+ml0LlsxFIDMoJsnIn15MxI3niLF1maHvqtss1ui4UFHGBGHVvlBrl4R
	/wpTUVgjNNMRFrAhD/p7xSOf0JwaZ3ZnmEEkFp8DkG5FO3zL7HIL+Ou5UtNYp2E2znlg3g
	C/Vbh7H+uWhe3brw4tLpRtBb4LhBg7Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-BjseGvIIMvqLIzlpP8D98Q-1; Mon, 06 Oct 2025 14:28:52 -0400
X-MC-Unique: BjseGvIIMvqLIzlpP8D98Q-1
X-Mimecast-MFC-AGG-ID: BjseGvIIMvqLIzlpP8D98Q_1759775332
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dbd8484abbso71284691cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 11:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775332; x=1760380132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2132KzKlEg7eZJV1T1X/BFB3ZV+a5iyDQTo1o0ZTuYk=;
        b=jZy5gyQz5aTPIzUd1rrK3kunr75j+BYGfctjBrFzpN7BV5hgsEARU92LysQB603YqY
         Yoy8DZ32jFphWVuc9pptVbW0uOylwoYe26PghncViIUn/1AQBdOQyDJF+NpTNneGburK
         08joJ/tfL7+8Prr5rFVKzhxHE77bPWxHWy0xdL6g3J7wAyO6m3kpmTgxcKvR+NpSgw3m
         qvAWrOXTc+Jy4JN4oXOiq/SCmBWlEvJ+9+PgwWBVkUVqftni6cmN3T06AKWSPj5LUO9v
         cJR20588rgfSb4DD/Ttpp0ozTSCaJsnvVgNM/SIEpeVsIN6vM0OKZmVO+fdH6G4/YwAH
         lcEw==
X-Gm-Message-State: AOJu0YyhoU+FhB+uYjZxLa3KeYZW5t2+GF4R9hUp3p5nzEwpui4cgda0
	FHMrXq/T8sn9sDFbJNlbCvdDO8J1K9I3+xq/IDuyGszqz3EO0V3i6+il73ZttVpbsTgs3MPsZRP
	zR0iJ/3GlLqkW0cbDoXChbW7EXoSUtfrveaJ2xeuUF1c+Ru9szJVYroBOsIyYvvJexO+gkYU=
X-Gm-Gg: ASbGncu7Lhkkeni4E5u2tslfQRjZUzo14iKMotdqu/k6GUVgPdtvgTjgFjzvG5B/2jj
	aza15CwdroHS9CWzX2rTK5eUlA9MryPLM732F6AJ7Afc5AMJByFUnaM9h5dSiVCW0ROywoROn38
	qnoeCy9CJNgvRAwYofQz3ImfBEmBdyyevwDM5HlBReb4+NH+a7FZfEn+Pis6G8f+lLnY2fdgHca
	mFEZDVJ1QrB1LIp862U9ChFPd1mYYeqkecKO6WEqrld4PDsgsSWWnT7Fdi7jDvBUynHpg9nZbqa
	9f8Jmh/HyQwtfmzJpr7RVKlbEQU60MHNhJkgRMQZSD91lHM=
X-Received: by 2002:a05:622a:1a13:b0:4b7:b010:9398 with SMTP id d75a77b69052e-4e576b0ffbamr163131531cf.66.1759775331870;
        Mon, 06 Oct 2025 11:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvJFNQ8hCj74WFsLsCeRYCDaNBfIys7iSz9areHdCvtcHBMDj8GCUTWnLquD8XfRveL1bKaQ==
X-Received: by 2002:a05:622a:1a13:b0:4b7:b010:9398 with SMTP id d75a77b69052e-4e576b0ffbamr163131121cf.66.1759775331317;
        Mon, 06 Oct 2025 11:28:51 -0700 (PDT)
Received: from [10.17.16.251] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129f10sm1324532785a.9.2025.10.06.11.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:28:50 -0700 (PDT)
Message-ID: <ec1dd178-890f-4eb7-b6e6-e027e7c2d7b3@redhat.com>
Date: Mon, 6 Oct 2025 14:28:50 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf tools: Remove /SYSV from no_dso maps
To: Ian Rogers <irogers@google.com>, Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
 jolsa@kernel.org
References: <20251006175710.1179040-1-mpetlan@redhat.com>
 <20251006175710.1179040-2-mpetlan@redhat.com>
 <CAP-5=fXo2+tKbTtNKN8oxiva+rKYB2AMpOCjA4+5xxNagC01UQ@mail.gmail.com>
Content-Language: en-US
From: Joe Mario <jmario@redhat.com>
In-Reply-To: <CAP-5=fXo2+tKbTtNKN8oxiva+rKYB2AMpOCjA4+5xxNagC01UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/6/25 2:01 PM, Ian Rogers wrote:
> On Mon, Oct 6, 2025 at 10:57 AM Michael Petlan <mpetlan@redhat.com> wrote:
>>
>> We will need it for upcoming commits. Also adjust the function
>> calls in perf-inject, in order not to break the logic.
>>
>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>>
>> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
>> ---
>>  tools/perf/builtin-inject.c | 4 ++--
>>  tools/perf/util/map.c       | 5 +++--
>>  tools/perf/util/map.h       | 6 +++++-
>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>> index a114b3fa1bea..cc090da5c445 100644
>> --- a/tools/perf/builtin-inject.c
>> +++ b/tools/perf/builtin-inject.c
>> @@ -773,7 +773,7 @@ static int tool__inject_build_id(const struct perf_tool *tool,
>>
>>         if (is_anon_memory(filename) || flags & MAP_HUGETLB)
>>                 return 0;
>> -       if (is_no_dso_memory(filename))
>> +       if (is_no_dso_memory(filename) || is_shared_memory(filename))
>>                 return 0;
>>
>>         if (inject->known_build_ids != NULL &&
>> @@ -813,7 +813,7 @@ static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
>>         /* Return to repipe anonymous maps. */
>>         if (is_anon_memory(filename) || flags & MAP_HUGETLB)
>>                 return 1;
>> -       if (is_no_dso_memory(filename))
>> +       if (is_no_dso_memory(filename) || is_shared_memory(filename))
>>                 return 1;
>>
>>         if (dso__read_build_id(dso)) {
>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>> index b46c68c24d1c..6d13b4602970 100644
>> --- a/tools/perf/util/map.c
>> +++ b/tools/perf/util/map.c
>> @@ -133,12 +133,13 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>>         if (ADD_RC_CHK(result, map)) {
>>                 char newfilename[PATH_MAX];
>>                 struct dso *dso;
>> -               int anon, no_dso, vdso, android;
>> +               int anon, no_dso, vdso, android, shared;
>>
>>                 android = is_android_lib(filename);
>>                 anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
>>                 vdso = is_vdso_map(filename);
>>                 no_dso = is_no_dso_memory(filename);
>> +               shared = is_shared_memory(filename);
>>                 nsi = nsinfo__get(thread__nsinfo(thread));
>>
>>                 if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
>> @@ -174,7 +175,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>>                 assert(!dso__kernel(dso));
>>                 map__init(result, start, start + len, pgoff, dso, prot, flags);
>>
>> -               if (anon || no_dso) {
>> +               if (anon || no_dso || shared) {
>>                         map->mapping_type = MAPPING_TYPE__IDENTITY;
>>
>>                         /*
>> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
>> index 9cadf533a561..616f32504e46 100644
>> --- a/tools/perf/util/map.h
>> +++ b/tools/perf/util/map.h
>> @@ -258,10 +258,14 @@ static inline int is_anon_memory(const char *filename)
>>  static inline int is_no_dso_memory(const char *filename)
>>  {
>>         return !strncmp(filename, "[stack", 6) ||
>> -              !strncmp(filename, "/SYSV", 5)  ||
>>                !strcmp(filename, "[heap]");
>>  }
>>
>> +static inline int is_shared_memory(const char *filename)
>> +{
>> +       return !strncmp(filename, "/SYSV", 5);
>> +}
> 
> Shared memory could happen because of two mmaps having the same file
> and offset. Is the mapping shared within or across processes? Perhaps
> there is a clearer and more capable API hiding here.

Hi Ian:
We see it happening both within a process and across processes, where the code does something like this:

    shmid = shmget((key_t)0, 8192, IPC_CREAT|0777); 
    shmat_addr1 = shmat(shmid, (char *)0, 0);
    shmat_addr2 = shmat(shmid, (char *)0, 0);

The separate shmat() calls can either be in the same process or different processes.  As long as they use the same shmid and a NULL address, they end up with different virtual addresses pointing to the same location in shared memory.

Then if cacheline contention occurs from accesses to shmat_addr1 and shmat_addr2, perf c2c cannot detect it.

I hope this helps.
Thanks,
Joe

> 
> Thanks,
> Ian
> 
>> +
>>  static inline void map__set_start(struct map *map, u64 start)
>>  {
>>         RC_CHK_ACCESS(map)->start = start;
>> --
>> 2.47.3
>>
> 

