Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5905632A4
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087239; cv=none; b=DdU2bD7EPM9g5MSzf8n2Pt4/Afkc5bL231ppADvd0q+0hhzcpu5oflCPve0kPkkmufls053DvQRzgKMqB81kJKBtq8WRrHnB49MetkJ5hjdyx8vEsyOBUviVlyuoi2dzJidZ81nmAHBWU6kq9fktmEQjPxbVE0k6kEbmw0cpV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087239; c=relaxed/simple;
	bh=U6PpWk46mEeXKnyaHQSE9sGanlQTQSblyiO/JAeoMwQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=c9Kx7eeu5Ccp5pKwVevmpO59HmhaX90U5F/knILonMmqCPI/+a3QYtTG79m2tISvtixzQNl9zmPv2JGbFmfJBnAxeF3lN2RQyXW5CARjsrrAYIgSZ7uCEdZd8mB0EKKbbjG7egGMjVCOECrDsyaik7dTy9dNsarSBXQ6Ob9RCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0oAYOUY; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0oAYOUY"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5e94a057300so774861e0c.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792087229; x=1792692029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YEKhz/ZK03jGlV3S7VR78poz8/WFBC4txQautcq3ygk=;
        b=j0oAYOUYAJmf5jHFTjHuds9S6AfGgQWbjMu9EOtM3sqNkC34LjFASkdBp2Qq4KCLuK
         NBychnVGQfIqoFkFABDt2k4egjojNnGjFn7A9PCemyd2FLGdZL2/Y4VjDM/PA6074Tgv
         4a4jK+1r7pdXQ8gNgugfkx9OJ7HMDy6kDsB6sYq+jRsboo+XKVba7XIfBctEV4tYAV+8
         GzfnQ3BepTM1XzWK7SP/irjtF1ZlmeWi6eT0LdCUzLfV/HcV9DCooPseKP7bctEnsYXY
         vmYfL7l7JACMHvfMyT8CLjmQXKMNNYOIOMkmeK9tnyfQ7lcK8RvlgMLiX7ntVYutdmB7
         2cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087229; x=1792692029;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEKhz/ZK03jGlV3S7VR78poz8/WFBC4txQautcq3ygk=;
        b=uyL7VcvtGkCTei62Gyw/XlAfeoYnUtuEjmAycCr2g/QUHpebipSzktrqyJCDZ6fF/v
         5pDiBIgZL/xOSft3qghzonsy5fka21sk8mtb5vPBp6vYen2C7AHEmcjXDQUkG5/jb+S1
         wa1/pwTARNQak+SlBrpLeKr4b7KIT44H3Sa2AWQtHvZyiUGTQvTVHJCqtHSl2XTbTaju
         8M1D1K0JyqMeNbFOBjSYffbFuN/UgIsdhXuF1C9b6sI2mUTihaBsBdNrT52Z64bIN1bp
         2Ezza/SqFxsCq38wu2nYlXfnYFQG9U/z7ml56XxIp1IynPBugOYMoJz0mRXrr+C6TNJW
         V+JA==
X-Forwarded-Encrypted: i=1; AKwUvBxUkVlJda8Vk5bJls2/oPiZ3IXxr3ojNKjrJbZOgZxgRnAzNhP5qGD5dLEUXErSCzqt+yUHZ2F8KW7VzCQQAW+V@vger.kernel.org
X-Gm-Message-State: AFq9FYLisQMp9NPg5kBpoxFkPTvIMjpqUuXjO2WT1Zzu9B7UXAMEKWgA
	knuIcgb3H2nBspMBTmS6Hgso3UZuBZHsF0EdnVaBq2Ay/wyRmZU1Cqn0
X-Gm-Gg: AYBFou1TX/lverUbI5ISLg0RfXwRM0FIU1bep5iqDhYWikYZpCGDtC5iVG6oj7VpTk9
	ZWKEp0dlmayj8zPLvNiInQ8Ml2vA0/vwZYAvSVGBx8DuQtPedORbmf7StEiHL9GmJOQ8YXf80BK
	DEuavi4slL3RU5FTSGBzq+1gsjykjhRx/LXiAcZ6y7uhbgOFLI1csNQLDbZONWHMNpqDA29c++3
	bmuXzyu5lRqfU7ztz27+SmPWSUyVJ/x6z9+Dh87Ud3Gjdyb1mpUJEKS94caHCvGPRzRAy5OasuB
	tEx39+bW8fAYSwec7s0ywtYI8THFAmS1mOJpHnUUbLkSQxEsUMrkyv3bqDwhxhbeSlEuaLXIUpJ
	vkBuNimk/yP6R494/EosQmM0+LWQ8lh0Xvu1V1kpm4Jj352CKgVC9xPJZG2y/+9mSO8n7yRTrub
	iJGQY9+l+2k4oJwlawjpDVkzQjEO0IdU6bJAiuuxh+8/8VqVk+6k+L3OhPF+KXoFB7Uo+qSgfP3
	+x6wK8Xrr+AbWo=
X-Received: by 2002:a05:6122:3295:b0:5dc:d0cb:7d80 with SMTP id 71dfb90a1353d-5e91f4934b5mr7341757e0c.11.1792087228643;
        Thu, 15 Oct 2026 11:00:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:388:90c2:72bb:18de:b9f8:b3f7:6f13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9947b81asm260312e0c.8.2026.10.15.11.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 11:00:27 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:00:21 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/11] perf tools: Factor out dso__find_binary_type()
User-Agent: Thunderbird for Android
In-Reply-To: <atEI2Ja4xpCnV7yI@google.com>
References: <20261013172155.160869-1-namhyung@kernel.org> <20261013172155.160869-8-namhyung@kernel.org> <atDSmfwd4v_oLg4m@x2> <atEI2Ja4xpCnV7yI@google.com>
Message-ID: <5514C8F1-3331-4E74-B6AE-607B3A632F0A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 15, 2026 2:09:44 PM GMT-03:00, Namhyung Kim <namhyung@kernel=2E=
org> wrote:
>On Thu, Oct 15, 2026 at 10:18:17AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Tue, Oct 13, 2026 at 10:21:51AM -0700, Namhyung Kim wrote:
>> > Separate out the logic to detect binary type of a DSO=2E  It checks i=
f
>> > the candidate file contains "=2Etext" section=2E  There could be data=
-only
>> > DSOs but as our use cases focus on the code (perf annotate or intel
>> > PT), we can ignore them for now=2E
>> =20
>> > But it also can fail due to open file limit=2E  Handle the case by
>> > retrying with _dso__data_open_lock=2E
>> =20
>> > Introduce bintype_searched flag and it accessors to prevent repeated
>> > (failed) search=2E
>>=20
>> This one, when compiled with clang, catch this in all my build
>> containers:
>>=20
>>   LD      /tmp/build/perf-tools-next/tests/perf-test-in=2Eo
>> util/dso=2Ec:942:7: error: mutex '_dso__data_open_lock' is not held on =
every path through here [-Werror,-Wthread-safety-analysis]
>>   942 |                 if (dso__data_open_cnt) {
>>       |                     ^
>> util/dso=2Ec:940:4: note: mutex acquired here
>>   940 |                         mutex_lock(dso__data_open_lock());
>>       |                         ^
>> util/dso=2Ec:942:7: error: reading variable 'dso__data_open_cnt' requir=
es holding mutex '_dso__data_open_lock'   CC      /tmp/build/perf-tools-nex=
t/util/maps=2Eo
>> [-Werror,-Wthread-safety-analysis]
>>   942 |                 if (dso__data_open_cnt) {
>>       |                     ^
>> util/dso=2Ec:943:4: error: calling function 'close_first_dso' requires =
holding mutex '_dso__data_open_lock' exclusively [-Werror,-Wthread-safety-a=
nalysis]
>>   943 |                         close_first_dso();
>>       |                         ^
>> util/dso=2Ec:949:3: error: releasing mutex '_dso__data_open_lock' that =
was not held [-Werror,-Wthread-safety-analysis]
>>   949 |                 mutex_unlock(dso__data_open_lock());
>>       |                 ^
>> 4 errors generated=2E
>> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile=2Ebui=
ld:95: /tmp/build/perf-tools-next/util/dso=2Eo] Error 1
>>   CC	  /tmp/build/perf-tools-next/util/thread=2Eo
>>=20
>> perf adds -Wthread-safety for clang builds (tools/perf/Makefile=2Econfi=
g),
>> so it is -Werror there=2E
>>=20
>> This is because __dso__find_binary_type() takes _dso__data_open_lock on=
ly
>> on the first retry, under needs_open_lock, and then reads
>> dso__data_open_cnt and calls close_first_dso(); with the lock taken
>> conditionally the analyzer can't see it held on every path=2E  And for =
the
>> try_to_open_dso() caller, which already holds it, the requirement was
>> only implicit, the helper had no annotation for clang to check=2E
>>=20
>> I've folded the following into the patch, see if it is acceptable:
>>=20
>> diff --git a/tools/perf/util/dso=2Ec b/tools/perf/util/dso=2Ec
>> index 47241077ad26=2E=2E8f274b8b1030 100644
>> --- a/tools/perf/util/dso=2Ec
>> +++ b/tools/perf/util/dso=2Ec
>> @@ -925,7 +925,8 @@ static int dso__find_binary_type_locked(struct dso =
*dso)
>>  }
>> =20
>>  #define FIND_MAX_RETRY  3
>> -static int __dso__find_binary_type(struct dso *dso, bool needs_open_lo=
ck)
>> +static int __dso__find_binary_type(struct dso *dso)
>> +	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
>>  {
>>  	int ret;
>>  	int retry =3D 0;
>> @@ -936,18 +937,12 @@ static int __dso__find_binary_type(struct dso *ds=
o, bool needs_open_lock)
>>  	mutex_unlock(dso__lock(dso));
>> =20
>>  	if (ret =3D=3D -1 && retry++ < FIND_MAX_RETRY) {
>> -		if (needs_open_lock && retry =3D=3D 1)
>> -			mutex_lock(dso__data_open_lock());
>> -
>>  		if (dso__data_open_cnt) {
>>  			close_first_dso();
>>  			goto again;
>>  		}
>>  	}
>> =20
>> -	if (retry > 0 && needs_open_lock)
>> -		mutex_unlock(dso__data_open_lock());
>> -
>>  	if (ret =3D=3D -1) {
>>  		mutex_lock(dso__lock(dso));
>>  		ret =3D dso__binary_type(dso);
>> @@ -961,7 +956,13 @@ static int __dso__find_binary_type(struct dso *dso=
, bool needs_open_lock)
>> =20
>>  enum dso_binary_type dso__find_binary_type(struct dso *dso)
>>  {
>> -	return __dso__find_binary_type(dso, /*needs_open_lock=3D*/true);
>> +	int ret;
>> +
>> +	mutex_lock(dso__data_open_lock());
>> +	ret =3D __dso__find_binary_type(dso);
>> +	mutex_unlock(dso__data_open_lock());
>> +
>> +	return ret;
>>  }
>> =20
>>  static void try_to_open_dso(struct dso *dso, struct machine *machine)
>> @@ -972,7 +973,7 @@ static void try_to_open_dso(struct dso *dso, struct=
 machine *machine)
>>  	if (dso_data->fd >=3D 0)
>>  		return;
>> =20
>> -	__dso__find_binary_type(dso, /*needs_open_lock=3D*/false);
>> +	__dso__find_binary_type(dso);
>>  	dso_data->fd =3D open_dso(dso, machine);
>> =20
>>  	if (dso_data->fd >=3D 0)
>>=20
>> __dso__find_binary_type() now requires _dso__data_open_lock, the public
>> dso__find_binary_type() takes it around the call, and the needs_open_lo=
ck
>> parameter goes away=2E  try_to_open_dso() stays as is: it is annotated
>> EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock), its four call sites tak=
e
>> the lock first, and now clang checks the whole chain=2E
>>=20
>> The patches I took (v5 07/11 onward) build with clang 22=2E1=2E8 here a=
nd
>> 'perf test dso' passes (read, cache, reopen), so please fold something
>> like this if you respin, or let me know if you'd rather have it done
>> differently=2E
>
>I think it'd grab the dso open lock unnecessarily, but it'd be simpler=2E
>So I'm fine with the patch and thanks for the fix!
>
>Do you want me to send the whole series again?  Or can you apply the fix
>on top?


No need, I'll apply them fix myself=2E=20
=20
- Arnaldo
>
>Thanks,
>Namhyung
>

- Arnaldo 
