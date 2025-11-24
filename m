Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B232F999F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980012; cv=none; b=G8wQ9HBavRKbQRKYcnh5XfFU/z0HTeHTNBh+CyKWXF0yesz3R/v0cnJDTf5iCyZTC5SlAAU75L/xM4v9GqU+s83aGnjl5rJf8uGPEWzHWG93GYlo9q9Ea/uIKWw0Xl8XGvz40jcJgiLVyBK2YLanDh6mERdWbpYvqrjsvU+rwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980012; c=relaxed/simple;
	bh=E2mtpH19U8j8jIV9IR5c46jY1Glx57QfhN+zJ4lLcUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heN2BF5W/lNfPiWo6y1Tk9FrhZBD50B7AZle9xta5//8v5vJ5kvaFpaLLKykR02q8zJESO4qRAYkk+t0jIe3ErhwUG+s2AArgdjrfqKzjXyJYACqWHS/h4k8yjWszaxzaEc70bYfc/Yak/YNkIGpMVzbbdmb/Jefx63+r8eBpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ED0jjU41; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ED0jjU41"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775895d69cso16777605e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 02:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763980007; x=1764584807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erK2DfySlztCVBsJUe6Z0ICtCoMBnQeia1yva5R1x0I=;
        b=ED0jjU41nZu3U9q+i4Oglv9F1FIn9GD+egdcdZ46W7dNLV0tTTkd1zQMepJSx7Ywpy
         dHn1HjDuwPpueT6h7fLQgz1YZYt4ttc6ytSRNeRGjKQxhFfTvLXJuN1Be41L1TMJJNf4
         tCew3S+E/oOz/Nh8hMde2nt6T9Uo1+hvRQaqGlFpURmsDsSsUU7wFyERxmKn5CjBWQIS
         Fp4SsPk2EIR5ZD6EvDmD0KCl/G3q/SD2i9wo089+gsXkuh2rt5MRUfgx03weFGlmNKJ/
         pzQ+bGwOOvT35K7y0DGHPXhINxbWYhNGUa722Rt4OmBfCH6mL5C5KY19yiYDplVXh2Pp
         oUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980007; x=1764584807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erK2DfySlztCVBsJUe6Z0ICtCoMBnQeia1yva5R1x0I=;
        b=rY0JlScWblt/af0ANRQ61/PuWy14QeeZdg8SfRBFM3xfy2lKWySHN4eCTtDzGStupQ
         7TWhtUxqqQdWHQpqqobJhEZgkdbVDDxrqUoAiy9nsWmhQTXN59ohVhf1D9EI0gwtKxQg
         oVYs7HAVtgvUCmXzbZkyedsCRDxFC9nxZskvz3dUFiJ5ZignUHtE2rt1TGSAuLkAJ6dZ
         YfRjzN73idHiUcYnGXeCzPMwmsZnoyKVWAhaj8gfSsvPkxrIq557dUkhyQouia/ytG3x
         xOfdfS16w5vPvWTe0lRSR6CjwUUYoU7eAygexU2HSgXFt6wEfO+c/fBH60ZmBOesqw51
         kxhw==
X-Forwarded-Encrypted: i=1; AJvYcCWr+aRdyHB0ZL1vTOW1yY52hppT7GXyEUvjTotAc6bfjMA4IPJUC9JdkZhJFJfqqUeozIydtUycyYZ+WuQKA1m/@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPTxdqXMSW5eqsD07LJ29LaQIkrPacNXKDdzFTV2ATROSUsgN
	GDCaiuqqnvCZEWBAQ2b736rdlh+Hq/DjK+oz6GVjlmhodQbYBXU5HZAu1NbMCSoehpo=
X-Gm-Gg: ASbGnctHwpwqhK6oRvBRzrRWQBXpxI1C1KHle41TsUfCWNupM+OtZuOnqGub5bEer4d
	guq/zIqSlrXZZ3csN96rT12yNdcvgxG3+ZCpOegqhk7qa+kNDzHagrysV7iqWXb7UojOYpZztSt
	Fce6K+1LOQuHxBn8CQnG2eXMlL1ZWmIqs5teG8aWTS3PTWoHPl1ZPYqrC6O7/rGRM8gUGXJGZdF
	nLBQZwvDiPHpM+MiKCIK/RtIEy16BhRlOotWt0fkjIWunx57xNT80Mz+56ISXXa7LXohNtPdkOh
	g8oO0sopRXJwDY7KlFxHDbcD22YMxuI+7+rco71sp3j9W3PtIrg3IIhOKPqHzA5qvEn3NIEji3+
	zWqviVuvJP2k8YryZvinOKSy/xEm7XglEGyJv2SpWoN1dQZmEXZBAnfsdd1xWj4nYdddH9zQQMB
	XCfuqXby/BvsnKAc6Q
X-Google-Smtp-Source: AGHT+IFBMeWY9WNwBY1aR31UvwdC2n49PHNFyig+flL9Gxqhu9Xk2coif8yLvItSef8KEQ1vFIzj4A==
X-Received: by 2002:a05:600c:1c92:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-477c0202473mr134784475e9.35.1763980006973;
        Mon, 24 Nov 2025 02:26:46 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3602d1sm192093515e9.5.2025.11.24.02.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 02:26:46 -0800 (PST)
Message-ID: <b4d88b1a-d522-4920-a189-30302a5a2029@linaro.org>
Date: Mon, 24 Nov 2025 10:26:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Don't read build-ids from non-regular files
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121-james-perf-non-block-v1-1-6ab2702ab573@linaro.org>
 <CAP-5=fVj-EQK=Dz8RRjrG+s1oH=1JrYzVu=oDGUHpP_iD=gP_A@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVj-EQK=Dz8RRjrG+s1oH=1JrYzVu=oDGUHpP_iD=gP_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/11/2025 5:13 pm, Ian Rogers wrote:
> On Fri, Nov 21, 2025 at 6:21 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Simplify the build ID reading code by removing the non-blocking option.
>> Having to pass the correct option to this function was fragile and a
>> mistake would result in a hang, see the linked fix. Furthermore,
>> compressed files are always opened blocking anyway, ignoring the
>> non-blocking option.
>>
>> We also don't expect to read build IDs from non-regular files. The only
>> hits to this function that are non-regular are devices that won't be elf
>> files with build IDs, for example "/dev/dri/renderD129".
>>
>> Now instead of opening these as non-blocking and failing to read, we
>> skip them. Even if something like a pipe or character device did have a
>> build ID, I don't think it would have worked because you need to call
>> read() in a loop, check for -EAGAIN and handle timeouts to make
>> non-blocking reads work.
>>
>> Link: https://lore.kernel.org/linux-perf-users/20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org/
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> I looked at the paths for hits to this function and found the following
>> categories:
>>
>> Devices, which non-block reads were unsuccessfully attempted, but are
>> now skipped:
>>   * /dev/dri/renderD129
>>
>> Non-valid paths, where 'non-regular' is irrelevant e.g.:
>>   * [vdso]
>>   * ... (deleted)
>>   * anon_inode:i915.gem
>>
>> Shared memory. These are regular and blocking reads work, so no changes
>> there:
>>   * /dev/shm/.org.chromium.Chromium.ejhzXY
>>
>> Symlinks to regular files. Also no change as is_regular_file() is true
>> for these too.
>> ---
>>   tools/perf/bench/inject-buildid.c  |  2 +-
>>   tools/perf/builtin-buildid-cache.c |  8 ++++----
>>   tools/perf/builtin-inject.c        |  4 ++--
>>   tools/perf/tests/pe-file-parsing.c |  4 ++--
>>   tools/perf/tests/sdt.c             |  2 +-
>>   tools/perf/util/build-id.c         |  4 ++--
>>   tools/perf/util/debuginfo.c        |  2 +-
>>   tools/perf/util/dsos.c             |  4 ++--
>>   tools/perf/util/libbfd.c           |  4 ++--
>>   tools/perf/util/libbfd.h           |  5 ++---
>>   tools/perf/util/symbol-elf.c       | 13 ++++++-------
>>   tools/perf/util/symbol-minimal.c   |  9 ++++++---
>>   tools/perf/util/symbol.c           |  5 ++---
>>   tools/perf/util/symbol.h           |  2 +-
>>   tools/perf/util/synthetic-events.c |  2 +-
>>   15 files changed, 35 insertions(+), 35 deletions(-)
>>
>> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
>> index 12387ea88b9a..aad572a78d7f 100644
>> --- a/tools/perf/bench/inject-buildid.c
>> +++ b/tools/perf/bench/inject-buildid.c
>> @@ -85,7 +85,7 @@ static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
>>          if (typeflag == FTW_D || typeflag == FTW_SL)
>>                  return 0;
>>
>> -       if (filename__read_build_id(fpath, &bid, /*block=*/true) < 0)
>> +       if (filename__read_build_id(fpath, &bid) < 0)
>>                  return 0;
>>
>>          dso->name = realpath(fpath, NULL);
>> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
>> index 2e0f2004696a..c98104481c8a 100644
>> --- a/tools/perf/builtin-buildid-cache.c
>> +++ b/tools/perf/builtin-buildid-cache.c
>> @@ -180,7 +180,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
>>          struct nscookie nsc;
>>
>>          nsinfo__mountns_enter(nsi, &nsc);
>> -       err = filename__read_build_id(filename, &bid, /*block=*/true);
>> +       err = filename__read_build_id(filename, &bid);
>>          nsinfo__mountns_exit(&nsc);
>>          if (err < 0) {
>>                  pr_debug("Couldn't read a build-id in %s\n", filename);
>> @@ -204,7 +204,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
>>          int err;
>>
>>          nsinfo__mountns_enter(nsi, &nsc);
>> -       err = filename__read_build_id(filename, &bid, /*block=*/true);
>> +       err = filename__read_build_id(filename, &bid);
>>          nsinfo__mountns_exit(&nsc);
>>          if (err < 0) {
>>                  pr_debug("Couldn't read a build-id in %s\n", filename);
>> @@ -280,7 +280,7 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
>>          if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
>>                  return true;
>>
>> -       if (filename__read_build_id(filename, &bid, /*block=*/true) == -1) {
>> +       if (filename__read_build_id(filename, &bid) == -1) {
>>                  if (errno == ENOENT)
>>                          return false;
>>
>> @@ -309,7 +309,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
>>          int err;
>>
>>          nsinfo__mountns_enter(nsi, &nsc);
>> -       err = filename__read_build_id(filename, &bid, /*block=*/true);
>> +       err = filename__read_build_id(filename, &bid);
>>          nsinfo__mountns_exit(&nsc);
>>          if (err < 0) {
>>                  pr_debug("Couldn't read a build-id in %s\n", filename);
>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>> index bd9245d2dd41..0e40f2a4bd18 100644
>> --- a/tools/perf/builtin-inject.c
>> +++ b/tools/perf/builtin-inject.c
>> @@ -668,12 +668,12 @@ static int dso__read_build_id(struct dso *dso)
>>
>>          mutex_lock(dso__lock(dso));
>>          nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0)
>> +       if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
>>                  dso__set_build_id(dso, &bid);
>>          else if (dso__nsinfo(dso)) {
>>                  char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
>>
>> -               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0)
>> +               if (new_name && filename__read_build_id(new_name, &bid) > 0)
>>                          dso__set_build_id(dso, &bid);
>>                  free(new_name);
>>          }
>> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
>> index 8b31d1d05f90..30c7da79e109 100644
>> --- a/tools/perf/tests/pe-file-parsing.c
>> +++ b/tools/perf/tests/pe-file-parsing.c
>> @@ -37,7 +37,7 @@ static int run_dir(const char *d)
>>          size_t idx;
>>
>>          scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
>> -       ret = filename__read_build_id(filename, &bid, /*block=*/true);
>> +       ret = filename__read_build_id(filename, &bid);
>>          TEST_ASSERT_VAL("Failed to read build_id",
>>                          ret == sizeof(expect_build_id));
>>          TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
>> @@ -49,7 +49,7 @@ static int run_dir(const char *d)
>>                          !strcmp(debuglink, expect_debuglink));
>>
>>          scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
>> -       ret = filename__read_build_id(debugfile, &bid, /*block=*/true);
>> +       ret = filename__read_build_id(debugfile, &bid);
>>          TEST_ASSERT_VAL("Failed to read debug file build_id",
>>                          ret == sizeof(expect_build_id));
>>          TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
>> diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
>> index 6132f1af3e22..93baee2eae42 100644
>> --- a/tools/perf/tests/sdt.c
>> +++ b/tools/perf/tests/sdt.c
>> @@ -31,7 +31,7 @@ static int build_id_cache__add_file(const char *filename)
>>          struct build_id bid = { .size = 0, };
>>          int err;
>>
>> -       err = filename__read_build_id(filename, &bid, /*block=*/true);
>> +       err = filename__read_build_id(filename, &bid);
>>          if (err < 0) {
>>                  pr_debug("Failed to read build id of %s\n", filename);
>>                  return err;
>> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
>> index 35505a1ffd11..fdb35133fde4 100644
>> --- a/tools/perf/util/build-id.c
>> +++ b/tools/perf/util/build-id.c
>> @@ -122,7 +122,7 @@ int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sb
>>          struct build_id bid = { .size = 0, };
>>          int ret;
>>
>> -       ret = filename__read_build_id(pathname, &bid, /*block=*/true);
>> +       ret = filename__read_build_id(pathname, &bid);
>>          if (ret < 0)
>>                  return ret;
>>
>> @@ -848,7 +848,7 @@ static int filename__read_build_id_ns(const char *filename,
>>          int ret;
>>
>>          nsinfo__mountns_enter(nsi, &nsc);
>> -       ret = filename__read_build_id(filename, bid, /*block=*/true);
>> +       ret = filename__read_build_id(filename, bid);
>>          nsinfo__mountns_exit(&nsc);
>>
>>          return ret;
>> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
>> index bb9ebd84ec2d..4a559b3e8cdc 100644
>> --- a/tools/perf/util/debuginfo.c
>> +++ b/tools/perf/util/debuginfo.c
>> @@ -115,7 +115,7 @@ struct debuginfo *debuginfo__new(const char *path)
>>           * incase the path isn't for a regular file.
>>           */
>>          assert(!dso__has_build_id(dso));
>> -       if (filename__read_build_id(path, &bid, /*block=*/false) > 0)
>> +       if (filename__read_build_id(path, &bid) > 0)
>>                  dso__set_build_id(dso, &bid);
>>
>>          for (type = distro_dwarf_types;
>> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
>> index 64c1d65b0149..0a7645c7fae7 100644
>> --- a/tools/perf/util/dsos.c
>> +++ b/tools/perf/util/dsos.c
>> @@ -81,13 +81,13 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
>>                  return 0;
>>          }
>>          nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
>> +       if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
>>                  dso__set_build_id(dso, &bid);
>>                  args->have_build_id = true;
>>          } else if (errno == ENOENT && dso__nsinfo(dso)) {
>>                  char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
>>
>> -               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
>> +               if (new_name && filename__read_build_id(new_name, &bid) > 0) {
>>                          dso__set_build_id(dso, &bid);
>>                          args->have_build_id = true;
>>                  }
>> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
>> index 01147fbf73b3..91b431eae0d7 100644
>> --- a/tools/perf/util/libbfd.c
>> +++ b/tools/perf/util/libbfd.c
>> @@ -383,13 +383,13 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>>          return err;
>>   }
>>
>> -int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block)
>> +int libbfd__read_build_id(const char *filename, struct build_id *bid)
>>   {
>>          size_t size = sizeof(bid->data);
>>          int err = -1, fd;
>>          bfd *abfd;
>>
>> -       fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
>> +       fd = open(filename, O_RDONLY);
> 
> We will need the is_regular_file test here.
> 

It's only currently called from places where it's already checked. But 
it's a public function, so it makes sense to check again. Will add it.

>>          if (fd < 0)
>>                  return -1;
>>
>> diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
>> index e300f171d1bd..953886f3d62f 100644
>> --- a/tools/perf/util/libbfd.h
>> +++ b/tools/perf/util/libbfd.h
>> @@ -25,7 +25,7 @@ void dso__free_a2l_libbfd(struct dso *dso);
>>   int symbol__disassemble_libbfd(const char *filename, struct symbol *sym,
>>                               struct annotate_args *args);
>>
>> -int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block);
>> +int libbfd__read_build_id(const char *filename, struct build_id *bid);
>>
>>   int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
>>
>> @@ -59,8 +59,7 @@ static inline int symbol__disassemble_libbfd(const char *filename __always_unuse
>>   }
>>
>>   static inline int libbfd__read_build_id(const char *filename __always_unused,
>> -                                       struct build_id *bid __always_unused,
>> -                                       bool block __always_unused)
>> +                                       struct build_id *bid __always_unused)
>>   {
>>          return -1;
>>   }
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 9e820599bab3..6b35c5bec610 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -860,20 +860,20 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>>          return err;
>>   }
>>
>> -static int read_build_id(const char *filename, struct build_id *bid, bool block)
>> +static int read_build_id(const char *filename, struct build_id *bid)
>>   {
>>          size_t size = sizeof(bid->data);
>>          int fd, err;
>>          Elf *elf;
>>
>> -       err = libbfd__read_build_id(filename, bid, block);
>> +       err = libbfd__read_build_id(filename, bid);
>>          if (err >= 0)
>>                  goto out;
>>
>>          if (size < BUILD_ID_SIZE)
>>                  goto out;
>>
>> -       fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
>> +       fd = open(filename, O_RDONLY);
>>          if (fd < 0)
>>                  goto out;
>>
>> @@ -894,13 +894,13 @@ static int read_build_id(const char *filename, struct build_id *bid, bool block)
>>          return err;
>>   }
>>
>> -int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
>> +int filename__read_build_id(const char *filename, struct build_id *bid)
>>   {
>>          struct kmod_path m = { .name = NULL, };
>>          char path[PATH_MAX];
>>          int err;
>>
>> -       if (!filename)
>> +       if (!filename || !is_regular_file(filename))
>>                  return -EFAULT;
> 
> I wonder if -EWOULDBLOCK would be a better return code for the
> !is_regular_file test?
> 

Yep makes sense to me.

Thanks
James

>>
>>          err = kmod_path__parse(&m, filename);
>> @@ -918,10 +918,9 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
>>                  }
>>                  close(fd);
>>                  filename = path;
>> -               block = true;
>>          }
>>
>> -       err = read_build_id(filename, bid, block);
>> +       err = read_build_id(filename, bid);
>>
>>          if (m.comp)
>>                  unlink(filename);
>> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
>> index aeb253248895..b811db4157ab 100644
>> --- a/tools/perf/util/symbol-minimal.c
>> +++ b/tools/perf/util/symbol-minimal.c
>> @@ -85,7 +85,7 @@ int filename__read_debuglink(const char *filename __maybe_unused,
>>   /*
>>    * Just try PT_NOTE header otherwise fails
>>    */
>> -int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
>> +int filename__read_build_id(const char *filename, struct build_id *bid)
>>   {
>>          int fd, ret = -1;
>>          bool need_swap = false, elf32;
>> @@ -102,7 +102,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
>>          void *phdr, *buf = NULL;
>>          ssize_t phdr_size, ehdr_size, buf_size = 0;
>>
>> -       fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
>> +       if (!filename || !is_regular_file(filename))
>> +               return -EFAULT;
> 
> Same here.
> 
> Thanks,
> Ian
> 
>> +
>> +       fd = open(filename, O_RDONLY);
>>          if (fd < 0)
>>                  return -1;
>>
>> @@ -323,7 +326,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
>>          if (ret >= 0)
>>                  RC_CHK_ACCESS(dso)->is_64_bit = ret;
>>
>> -       if (filename__read_build_id(ss->name, &bid, /*block=*/true) > 0)
>> +       if (filename__read_build_id(ss->name, &bid) > 0)
>>                  dso__set_build_id(dso, &bid);
>>          return 0;
>>   }
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index cc26b7bf302b..d8fc5ea77f84 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1743,14 +1743,13 @@ int dso__load(struct dso *dso, struct map *map)
>>
>>          /*
>>           * Read the build id if possible. This is required for
>> -        * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work. Don't block in case path
>> -        * isn't for a regular file.
>> +        * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work.
>>           */
>>          if (!dso__has_build_id(dso)) {
>>                  struct build_id bid = { .size = 0, };
>>
>>                  __symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
>> -               if (filename__read_build_id(name, &bid, /*block=*/false) > 0)
>> +               if (filename__read_build_id(name, &bid) > 0)
>>                          dso__set_build_id(dso, &bid);
>>          }
>>
>> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
>> index 347106218799..3fb5d146d9b1 100644
>> --- a/tools/perf/util/symbol.h
>> +++ b/tools/perf/util/symbol.h
>> @@ -140,7 +140,7 @@ struct symbol *dso__next_symbol(struct symbol *sym);
>>
>>   enum dso_type dso__type_fd(int fd);
>>
>> -int filename__read_build_id(const char *filename, struct build_id *id, bool block);
>> +int filename__read_build_id(const char *filename, struct build_id *id);
>>   int sysfs__read_build_id(const char *filename, struct build_id *bid);
>>   int modules__parse(const char *filename, void *arg,
>>                     int (*process_module)(void *arg, const char *name,
>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>> index 5aa44c4aba62..2ba9fa25e00a 100644
>> --- a/tools/perf/util/synthetic-events.c
>> +++ b/tools/perf/util/synthetic-events.c
>> @@ -401,7 +401,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>>          nsi = nsinfo__new(event->pid);
>>          nsinfo__mountns_enter(nsi, &nc);
>>
>> -       rc = filename__read_build_id(event->filename, &bid, /*block=*/false) > 0 ? 0 : -1;
>> +       rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
>>
>>          nsinfo__mountns_exit(&nc);
>>          nsinfo__put(nsi);
>>
>> ---
>> base-commit: 134852abcbfa5f6a4a17619c8f44c857f800ae03
>> change-id: 20251119-james-perf-non-block-3296c96909aa
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

