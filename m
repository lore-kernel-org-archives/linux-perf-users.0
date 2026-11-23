Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463723;
	b=j3gFXwthTBM7+bH4Nlq4Iw7nR3ifXNG5TO8StEFJcUKE2P/am2YTRjZ014eq0o5qHaw5
	 6CWoXonHBlLAMtVut5HuoMzbuMmsnBKYfW0GFpV4Bu3Te+S2mZLXAOJXMy9AdVYHNc0E7
	 5Urq/zkL6G+poR89F5Q0IIsjjBORg4+d+1o/9lDnoXvTUFbvSJvMB82Q7VmQEe9/y7+Ls
	 iX2Mfrupu3nip1ZNL4txEzcICyvsiz3z5QkzPoFU/+C4v3Bwpuy9nY0A6IFk6B8wcCB4J
	 1mgDTk2Hz53zBzHfTIK/EGt6lptAgkes6HmH5Q+9Rii+9LTeqx4zgj5Z4foVkfhRIew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=y26CddRxslMKEDtGhRH1mgKHs/1RBt+iPeBTvAPGQt0=;
	b=cnmKfA6Fn0+XSlarkqATJu+EQVxclujw7EtM2HHGov40y9tzjsVdnzH7EDcbh3Uxc4fe
	 +cjcraevSbgkAT3IJPtFKQVpfyUf+Uh6g4Dh8k3QSF5QL2TtKqk0B4DfxorhYi2cYBf2Y
	 yDHd+ENLxPWQuxMR+Rb2noxn8x4WmwgB7yqwnneamyxVk84ym2BuCaLAdeKch4nxQWiin
	 PsMx21e8mpUKcuEByvcSX+ySRUfZW2tcOrl88slY9LRGnph0MQWI235zo+fRAY0DjAa+s
	 Id7h/FQyz7RSjDt8l47sLTjqtv0ZpttxU4X0Wfbb9hc/wfIbDkylMfnhRTPI78ECYOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uw0A3jxS;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F90606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F90606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uw0A3jxS
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d6554d96d3so2171060137.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463721; x=1796068521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y26CddRxslMKEDtGhRH1mgKHs/1RBt+iPeBTvAPGQt0=;
        b=uw0A3jxSPX8CqDEbKEq6aUEBJULIQtWBQXZCSkopbmKAvu/vQ+bPMrI3kNnTCY9m/L
         Ghxgq4xmntHOyfTFJqP8kfqLwERtLCILzmk3TQ7DLjkSt7VhonEoxJ0Ye6GYLz2i/xjv
         NmYUFCrsobmYNsJYeRsE3ts90VzgbTbXr+43WZRcrYmD4Kc17vad5kk8+jtI4rqu/OBE
         QpszEuZpSD8cENewdc/B3apM5ElUMYyp8M/ugZkbfo0pLQYq8d8clqp0ia/8cCgkv3bE
         neejocF8E2EvBBEgPw5JlrzhDjFw5ymz31OMQ+rcgqGH4nk/4EGn4v7S+lfXad9Jk8J8
         p9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463721; x=1796068521;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y26CddRxslMKEDtGhRH1mgKHs/1RBt+iPeBTvAPGQt0=;
        b=xgJ61Pa1RtAEeGSRUTGae6Mn68V+0oFX3DVnq6mE+O5LKastdwLg5a6l2UKTokaoy/
         Hess61BclxrIRS3DpxxDNUZQxYXudctor5XFvQCloKorWgEsiMLLqOq2BV9/jmmLiNyU
         W9rvMqZrZfJC/SWSZ5p/HJefvuGLntytdXQ8x39jRbIPQZrUn1HVgZuT24yppBAgJ5QK
         /iACRmRY6vM2iMocsAhsur6KvtuXzqb0BEaZresIFM+kHF9E+KTqaPOUzNHr1z4odPSp
         Fv/RiKljIZR7pk2b8jWaBX6Br6+3clQfs6BgodTBhhERUlZQYeIBKWkfN+4zkYyKYSMp
         0xPg==
X-Gm-Message-State: APuU4Z/GeAzhIMJcPNzig0ugccTtDHFftdxuk1PfXWKRrx0D1O7rjbye
	UosW1bQgTiCLnHllaCGVtFsZK8qjVtnwhSOJxJzVF2rn/WR/5d2R0XzkpCfIOw==
X-Gm-Gg: AZFdTZcGYh0/sEFefug22HRHxAOBeZ1pwRA44Ee4GlxY7xa7iS/PFvSgJw9p6w6Ya02
	kBkRScQO5xYomkRIAEpDWrVTv2uk7yS9wc+hlDcD8YYBzIWuA8/x8dmJ7T61kBNnBOI1q9kqwJs
	jM11ffjD6xrdf+E6XY3w7OWx83zGK6LQa9kXlHZUSmXczpo7TM624lE9eOVwDWLXvh9erIDJ+zt
	ReKAsbuVAaw+QlncNv853b8dTRN0LT2WHhiWyIECfU6Bp5VGpcHPqYff04JzDRz8oNEv6cDumDH
	eIihUd6IKUqzkMOGP7j2NT7jmlpGcaeFNMLZ1T9oIQmzd9DaBhvi6sfARXrpvUHa/zc9EpqNIYY
	Ibj18FRmEL0WAhPDYxj3ZGURsCDNJCgYqR1IbcT/FkKpc6GGjj9hNziJur2+qRorYgrU4KGbXRJ
	i480G2TFwzuylo6+2JlYeH11cOgUBmSUz4l7e2jxst0VX5SK+utbTOGNXPL965aSMHyvhtPZ34/
	KzxGxhaWSm9eUJasqFYvaNdblU5QytgpxIoE8ybf6BlkE+nUMHx8ncHFjVvJ5wrY8M8Z/jq9SVJ
	GyJaLAS8S6ueKjYgPJYsLPcEiJ5YxEJ61NZdGYoZ3DX1sg==
X-Received: by 2002:a05:6102:441e:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7d7393925f5mr6518303137.13.1795463721268;
        Mon, 23 Nov 2026 11:55:21 -0800 (PST)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:4262:70f1:57bf:e3a2])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e8265e55sm13034702137.11.2026.11.23.11.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:55:20 -0800 (PST)
Date: Mon, 23 Nov 2026 16:55:16 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_perf_build=3A_Only_enable_c?=
 =?US-ASCII?Q?ontext_analysis_with_Clang_23_or_later?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org> <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
Message-ID: <EC27692D-9692-4976-B7EA-4C3A91173CE3@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 23, 2026 3:44:12 PM GMT-03:00, Ian Rogers <irogers@google=2Eco=
m> wrote:
>On Mon, Nov 23, 2026 at 8:46=E2=80=AFAM James Clark <james=2Eclark@linaro=
=2Eorg> wrote:
>>
>> Context analysis requires Clang 23 or later (see
>> Documentation/dev-tools/context-analysis=2Erst), otherwise the build fa=
ils
>> on older versions, e=2Eg=2E Clang 18:
>>
>>   util/env=2Eh:142:39: error: use of undeclared identifier 'lock'
>>     142 |    struct rb_root          infos __guarded_by(&lock);
>>
>> Only enable it when the Clang version is supported=2E Leave the other
>> thread safety options enabled if they exist because they don't cause
>> build failures at the moment, and might provide benefits even without
>> -DWARN_CONTEXT_ANALYSIS=2E
>
>So we've had -Wthread-safety for a long time in the perf tree, I'm
>guessing __guarded_by is missing on older clang versions=2E Can we just
>stub out the __guarded_by for these old clang versions and keep the
>lock checking?

Looks way more reasonable, and no need for a feature test since we know th=
e compiler version when __guarded_by was introduced, right?=20

Regards,

- Arnaldo
>
>Thanks,
>Ian
>
>> Fixes: 321967859933 ("perf build: Enable context analysis and Clang thr=
ead-safety flags")
>> Signed-off-by: James Clark <james=2Eclark@linaro=2Eorg>
>> ---
>> Assisted by Claude Opus 5=2E5
>> ---
>>  tools/perf/Makefile=2Econfig | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/Makefile=2Econfig b/tools/perf/Makefile=2Econfi=
g
>> index aed2e952c8f3=2E=2Ef5adceee5589 100644
>> --- a/tools/perf/Makefile=2Econfig
>> +++ b/tools/perf/Makefile=2Econfig
>> @@ -65,11 +65,15 @@ ifeq ($(CC_NO_CLANG), 0)
>>      CXX :=3D $(CXX) $(CLANG_FLAGS) -fintegrated-as
>>    endif
>>
>> -  # Enable context analysis (linux/compiler-context-analysis=2Eh gates=
 its Clang
>> -  # attributes behind WARN_CONTEXT_ANALYSIS) and Clang thread-safety c=
hecks=2E
>> -  CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -Wthread-safety
>> +  CFLAGS +=3D -Wthread-safety
>>    CFLAGS +=3D $(call cc-option,-Wthread-safety-pointer -Wthread-safety=
-beta)
>> -  CFLAGS +=3D $(call cc-option,-fexperimental-late-parse-attributes)
>> +
>> +  # Enable context analysis (linux/compiler-context-analysis=2Eh gates=
 its Clang
>> +  # attributes behind WARN_CONTEXT_ANALYSIS)=2E Requires Clang 23 or l=
ater=2E
>> +  CLANG_MAJOR :=3D $(shell echo __clang_major__ | $(CC) -E -P -x c - 2=
>/dev/null)
>> +  ifeq ($(shell test "$(CLANG_MAJOR)" -ge 23 2>/dev/null && echo y),y)
>> +    CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -fexperimental-late-parse-attr=
ibutes
>> +  endif
>>  endif
>>
>>  include $(srctree)/tools/scripts/Makefile=2Earch
>>
>> ---
>> base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
>> change-id: 20261123-james-perf-late-parse-attr-4e996381859f
>>
>> Best regards,
>> --
>> James Clark <james=2Eclark@linaro=2Eorg>
>>
>

- Arnaldo 
