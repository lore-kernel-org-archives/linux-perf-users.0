Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A52E266C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144910; cv=none; b=fztBjhLyL+JMDQxyn43VHmduHGhC3lEsEeaSxYtxwqVRoVP8yH4tH+Vfsp3zGZ+ZqNdKX2t6+ZL5+50wUt3sgEDl+gMhG953LSshbxM5Y7sW261qpa/vAwVEVIoUYh6Y9YMut5OEWFWmeVN4hckpvkR/w6MXeWc3V4VRn8mlgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144910; c=relaxed/simple;
	bh=mR4dJqr/kRsaH7W3VkaiLJgPwY3uRTk2WenRHZJDliw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eEjOFXJwCE9hkMEID8oP9FIPKTaTPW07g6p8yAcs4QxY3XZEj9oz6dubUU6OI+6T9a59Bn/lWjVnm3DobAdKCoWd1UMNzcLEIwGr0p6wlcTYjP57db4UySg7w0janBx15dd1ADyHiNJ5Y21LHE0Tx7IZ24DSftnYzYrWHrtXPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO2NlgNO; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO2NlgNO"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-951c5ac6253so337997241.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775144908; x=1775749708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1d/eRtpKUBbGeXwWEqsynzXEyvi7SdWU5Nw4sF1GCq0=;
        b=OO2NlgNOU/7CCVHSfsQeCEPH+aLTiYs6s5JmLbme0PGVMdjQI3xmUwep8tKtDjhCzX
         nx+dEQvUE1hR+M+TgjoxVF3INs+T6vc1nXNGKryJBti/RRF5+3Cu1etnPbj+OhgIJsRQ
         dvPO2Si9SHxmBqZ06HPVUXhAvPpx4pTftgcOeWKPpFjRn+G+vs8pZJ7sAhAqULMcfAKU
         Vs11cZQItNrvIBFYBSpa50bk1//UTiD0fSn0JieHuEiZo0ZI0S196BQVImaJaLjkZDIE
         5Og63zbHSxta8A3+S1gSvoEuMaoO0WLUm+R0usEaCpnIfkldMoqWQaYLG5fS4aJUC/vk
         OUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144909; x=1775749709;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d/eRtpKUBbGeXwWEqsynzXEyvi7SdWU5Nw4sF1GCq0=;
        b=H+tqbuT7/Fo8SCYyJQ+UqTHDRcf9Y/y2OS/Sh+GNmJwL+673Z5zz0MoM7fs/F7CEsl
         Q/6q9o+O8NfuGqDHxbcKrmZxMIXZxEev93EZqYI2j5lxdGAFB9aykVJwIMCdYaWUjcHR
         nXcdglwgeSpf+wTFvmTjDqOfTrDprEP8NpeGg8wUS/yDe/9UEIrnWA7LJMT0j9+7zgp4
         rb1uF2hOWKkC9ZoOQthk8uX4h38s98tbPcHWEXdxfZW1s+Chvxb/7JsOhu1GQhWd8jGC
         3bV7aKtxxPTlk6mt8FBTa/c047QjJ/RRBT29kMzXYZhETt3OUxKgGxNCkq2moby/v/2T
         JJMg==
X-Forwarded-Encrypted: i=1; AJvYcCWHIn9hm6PTYBXfncjGTzBOGvoKo4PJF5whoY1XTjZKxf3p2S4D6rlAdY1oGJs2+864A21AM4d6+owDAURPDfcN@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYy7PU+DjX6evipPqjMa1Xx/uTdMR+JXwKqc+lrQV+iybEo4U
	GNl4j+/+DuG+AOpdaRwvYBT+8wG0ZZpwofxvPIaAnXsqIlb4QsL3bNfv
X-Gm-Gg: ATEYQzyX9xQNYdOCHc8WGUPmWERU6iN0NhYVyJo3gvrw/is/OYlZSPjkenYx9B0XloL
	nob+Sc+1HHjN48oTD95ouRPGxcTa0Fl4iBK4hfXEpNwx3ZTyBLq4KIZZq4c0Gg1SRw0ehqcFEvM
	Ab13g7Z9H5tJtkirksSZmPEK28W4i5pf48pXTTRTtDcXoK6wHufuMZXFPmLzFb5x7fk5rqbPE59
	x2HDnomEguuRZ771ycvapm6Xt+wPzRvDQtFJs67wCIpEGRiQTC3czFhLmwmj1tWXNp7yGRtJDf/
	PbSphMdE6euDCG+WjjZqWUGClMk1GCLl8Gwj7GITSQapeUMAt9avUAfMgwIPnx5JhGML7mB8gmX
	MCNxou6CUeNheskqI+yGfj5aQe3UZvVBkN9tMRcc2F1NLEWAnk+7YdMwPdzCCTS+rYArmdkdwWh
	lx8vYhXDaVQnymqmvGb1j1ILoFGHMMZ8BjBgL8c/l8uKOzgQiYEA==
X-Received: by 2002:a05:6102:3e26:b0:605:a89:d007 with SMTP id ada2fe7eead31-6058409b279mr1395979137.29.1775144908605;
        Thu, 02 Apr 2026 08:48:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:388:90c1:8f1:18a2:90d6:46f8:9787])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb84f2c5sm3652725241.5.2026.04.02.08.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 08:48:28 -0700 (PDT)
Date: Thu, 02 Apr 2026 12:48:23 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/4=5D_perf_symbol=3A_Add_missing_l?=
 =?US-ASCII?Q?ibgen=2Eh_include_to_get_basename=28=29_prototype?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fVv=5H-6DOaAr4BSDE=pKrxWDa9oduYbVTozYc-ZeeuRg@mail.gmail.com>
References: <20260402001740.2220481-1-acme@kernel.org> <20260402001740.2220481-5-acme@kernel.org> <CAP-5=fVv=5H-6DOaAr4BSDE=pKrxWDa9oduYbVTozYc-ZeeuRg@mail.gmail.com>
Message-ID: <1A659979-30FE-4E90-B4B3-5278A2242C51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 2, 2026 12:19:24 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> =
wrote:
>On Wed, Apr 1, 2026 at 5:20=E2=80=AFPM Arnaldo Carvalho de Melo <acme@ker=
nel=2Eorg> wrote:
>>
>> From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>>
>> This works in some places because there are tricks to prefer a GNU
>> version instead of the XPG version, but started breaking in some musl
>> libc systems due to some unrelated change that made libgen=2Eh stop bei=
ng
>> included by chance=2E
>>
>> Since symbol=2Eh is using basename(), make it include libgen=2Eh=2E
>
>Huh, this is being flagged by Sashiko:
>"""
>Could this include cause segmentation faults by exposing the POSIX versio=
n
>of basename() to the rest of the tools?
>
>According to the POSIX specification, if the input is an empty string
>or slashes, basename() can return a pointer to a statically allocated,
>read-only string literal (such as "=2E" or "/")=2E
>
>In tools/perf/util/probe-event=2Ec:convert_exec_to_group(), the code take=
s
>the return value of basename() and modifies it in-place:
>    ptr =3D basename(exec);
>    =2E=2E=2E
>    for (ptr2 =3D ptr; *ptr2 !=3D '\0'; ptr2++) {
>            if (!isalnum(*ptr2) && *ptr2 !=3D '_')
>                    *ptr2 =3D '_';
>    }
>If a user provides an empty target or "/", the POSIX basename() would
>return a read-only string=2E When the loop attempts to write a null or
>underscore into it, wouldn't it trigger an immediate segmentation fault?
>
>Is there a way we can safely duplicate the returned string before modifyi=
ng it,
>or ensure the inputs never resolve to these static strings?
>"""
>
>The story of the two basename versions and the issues appears in the
>man pages=2E The whole thing makes me think we should avoid basename :-)

:-)

I think we should just follow it's advice and use strdup in it's return, i=
n a helper, and have it's users free it afterwards=2E=20

- Arnaldo

>
>Thanks,
>Ian
>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> ---
>>  tools/perf/util/symbol=2Eh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/util/symbol=2Eh b/tools/perf/util/symbol=2Eh
>> index c67814d6d6d6f64a=2E=2Eb37ecc2e90f77efe 100644
>> --- a/tools/perf/util/symbol=2Eh
>> +++ b/tools/perf/util/symbol=2Eh
>> @@ -10,6 +10,7 @@
>>  #include <linux/rbtree=2Eh>
>>  #include <stdio=2Eh>
>>  #include <errno=2Eh>
>> +#include <libgen=2Eh>
>>  #include "addr_location=2Eh"
>>  #include "path=2Eh"
>>  #include "symbol_conf=2Eh"
>> --
>> 2=2E53=2E0
>>

- Arnaldo 
