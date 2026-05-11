Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACF425CCB
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516266; cv=none; b=PqEtDLyfVSlheojs0UaUi71GNuaBRhvCROVrG3obgQEcG26Dy/tkJXu0WWFkPKGHklzcUTuiTHoUokeznAo/L9RkHhWwajAkZW4XprTtfgUDGy4G43br6SiK2xKoLe18yDySjRGN6EYely3HNRFvvrV6UAnRedD0VbVhdhNddoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516266; c=relaxed/simple;
	bh=0ara9K7QdBKThaPril0a4YvO62DrR2+YYX2Gg4rGizw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu/jmE5insL7EO8Tg6sKR3Xsg07E34SLE/2NHHdWxc/tXQhFtqTWq1WkxJTswtPwoj7zdxz8oNK8wbRBy9ytH8/IDHwEKm1QNa8SeA3r5E9aj/ZWCxRgsQn3zKE/qzc9Ntyuu4ipwa7hjA3iH1IRv2RKac17aM+GiV+I/uFwz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+SEGZuG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+SEGZuG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so53701875e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778516263; x=1779121063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv+QO3gNHsfEC1WrzTCG9lEyRXfEmVBCtTyB0LNuW38=;
        b=h+SEGZuGPnT4f6kuY4LsnDaF8v7K7kR2bho0rinTzKRCdldzjHkg+ZAQssrZBFOFf8
         GFq48hXRqpYmQlrLBeE8I2UBFJFTwGu0dQpJ8D/RwxM3/o4hSGQLR/cZcMImAQGfx3Qn
         cPSEh1HOjCyt6wjdQgouuKni2iIau5yQAaBHhWjzdj3pWgBWoJ9fA1A0TsWi1CdJhPWm
         Xl6m4ij7MYNJyaCcFLoJDn7DP98b7Qx+CyR5ipYY+yqWRxQ2hxx25QM0/zLHaIvipqvI
         M08Y9jBILwBlLFPXrfMlc8pCitJBu0XhUXxz6b3AAmy8uGcV7oa1Bde0G1auq1irHMbT
         k6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516263; x=1779121063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bv+QO3gNHsfEC1WrzTCG9lEyRXfEmVBCtTyB0LNuW38=;
        b=lVmKka7ER7n7WSHs1FQ80XCKdYepVzfOjnegRFfWw8ZUtUlbwLHGaL+3tbtcgbSIf2
         YpBiASFk5Fm/7/MYuDdN3qTTL9Mx6A1ofC81NWlkd1+Y2QyG5/A/Cx7TFEC2IcInUyhW
         cwJ7mvHcveq92EHBcEbSgBOrX9UaAviSdRLeGa91DdPXJDLt42LMCLJuPcSlqaqdw5l0
         iN51kOekn0Ozf17WUkxX9P1JRRracZz542THFtG1rJLZAnJ35J0JGxT+gccerNyDW05r
         jr94vEZK2WZY9wGnbAiNR9bGIvyG6LEJZ6v0Zyz7vO4+6cqNG0OgudBohncpY30rjpF7
         HV4w==
X-Forwarded-Encrypted: i=1; AFNElJ+fVXi+udsFcGt5BknKZ5ZLWXSg9X9rVchC/VaJU1XkNmS5qRNjr+c0XEYGJCp0C7vnwPEAwsa2XRuQcAkJMFwR@vger.kernel.org
X-Gm-Message-State: AOJu0YzFz+RH+HFFt5QgbnvU6qpsW9ga467qREFurmu9qyjUzhFNhsJq
	lUTlzJMpGOa0gTaLmtctQq3uTCyhWHx1SLUjo9DRueaK3Z28sIgmO9TTDzpm6x+4Koc=
X-Gm-Gg: Acq92OFq3D6y1vD8mJ7BGOj+zNk5ud+QIVZTudAMA2/kYjMotzTn1gwEpO1NMiqfapF
	MeymqtIGuPqKlN1wRxUo7gN3XFlMSn/I1z3b/zzH3jp9NWHVb9si0qztswY9o8FP1lvz321O7Co
	Inu/or8PYx72klONPuUAkb6w44qf/OsdO+V1qhr4WagYRLXStT30i7Qri5rTQfveYfwvXPjw8wp
	KeX4+Qnb47mBZ9/WT2cXYm/VZjAxtI5O8rMWRcTfnEtLwu3i3F5O3lx/Wtch8e+UnRwILPs3qv1
	endH5jCmzR8oIce4Q+gMckx1cS6Mh5QowG5DL9gotneqk3ZImctX+96aztb2AQGFBuYkCQeSsW/
	RAd3gSuxAU2cfzlTbTxdo/FJ1ZWGu/ppTN3gZBCl402+lARGcJaj3ovodw3S0aDKoZ68vOToR8/
	Zib3/sjmFfdyQt2WQ7lRUzn3KaOXsveHko8WXVImc=
X-Received: by 2002:a05:600c:35d6:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-48e707033f0mr174096475e9.20.1778516263522;
        Mon, 11 May 2026 09:17:43 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e566cf7sm475125e9.0.2026.05.11.09.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:17:43 -0700 (PDT)
Message-ID: <970c4dd6-a2e6-4be7-afb3-63858d4d1f69@linaro.org>
Date: Mon, 11 May 2026 17:17:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Make leafloop workload immune to compiler
 options
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511-james-perf-leafloop-stack-v2-1-79f7383f545e@linaro.org>
 <CAP-5=fXtzHw2c_Er0WPpfFo1cfng46VXKvShb+kbdnSoxL1rmw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXtzHw2c_Er0WPpfFo1cfng46VXKvShb+kbdnSoxL1rmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/05/2026 4:38 pm, Ian Rogers wrote:
> On Mon, May 11, 2026 at 2:19 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Since the leafloop test program was moved into the main Perf binary as a
>> workload, it inherited the same compiler options as Perf. In this case
>> the -fstack-protector option broke the assumption that simple leaf
>> frames don't have a stack frame on Arm. This causes
>> test_arm_callgraph_fp.sh to pass even if the stack isn't augmented with
>> the link register, making the test useless.
>>
>> Fix it by rewriting the leaf function in assembly seeing as it's so
>> simple. Adding -fno-stack-protector would also work, but wouldn't be
>> robust against other future compiler option additions.
>>
>> The local variables and 'a' variable were never needed so remove them to
>> simplify.
>>
>> Assisted-by: GitHub-Copilot:GPT-5.5
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> Changes in v2:
>> - Push and pop asm sections - (Sashiko)
>> - Add .size directive - (Sashiko)
>> - Add asm label for done and test with LTO enabled - (Sashiko)
>> - Link to v1: https://lore.kernel.org/r/20260508-james-perf-leafloop-stack-v1-1-637c260b2da8@linaro.org
>> ---
>>   tools/perf/tests/workloads/leafloop.c | 40 +++++++++++++++++++++++++++--------
>>   1 file changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
>> index f7561767e32c..c20c75f7ba49 100644
>> --- a/tools/perf/tests/workloads/leafloop.c
>> +++ b/tools/perf/tests/workloads/leafloop.c
>> @@ -6,26 +6,48 @@
>>   #include "../tests.h"
>>
>>   /* We want to check these symbols in perf script */
>> -noinline void leaf(volatile int b);
>> -noinline void parent(volatile int b);
>> +noinline void leaf(void);
>> +noinline void parent(void);
>>
>> -static volatile int a;
>> -static volatile sig_atomic_t done;
>> +static volatile sig_atomic_t done asm("leafloop_done");
>>
>>   static void sighandler(int sig __maybe_unused)
>>   {
>>          done = 1;
>>   }
>>
>> -noinline void leaf(volatile int b)
>> +#if defined(__aarch64__)
>> +/*
>> + * Write leaf() in assembly so it stays as a minimal leaf function with no
>> + * stack frame and won't get silently broken in the future by any Perf wide
>> + * compilation options like -fstack-protector-all.
>> + */
>> +asm(
>> +       ".pushsection .text,\"ax\",%progbits\n"
>> +       ".global leaf\n"
>> +       ".type leaf, %function\n"
>> +       "leaf:\n"
>> +       "       adrp    x1, leafloop_done\n"
>> +       "       ldr     w2, [x1, #:lo12:leafloop_done]\n"
>> +       "       cbz     w2, leaf\n"
>> +       "       ret\n"
>> +       ".size leaf, .-leaf\n"
>> +       ".popsection\n"
>> +);
> 
> On reading this I thought, why can't we just use an asm block in a
> function, but I get it, you want specific function entry/exit to test
> the leaf unwinding feature.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Fwiw, looking at the test the command line is somewhat unusual:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/test_arm_callgraph_fp.sh?h=perf-tools-next#n32
> ```
> perf record -o "$PERF_DATA" --call-graph fp -e cycles//u
> --user-callchains -- $TEST_PROGRAM
> ```
> cycles//u rather than cycles:u and why the extra --user-callchains?
> 
> Thanks,
> Ian
> 

--user-callchains looks like it was to make the grep in the test easier 
so it didn't have to ignore the kernel part. But it might be redundant 
now after a later change I made.

cycles//u has always been there so there's no explanation. I thought 
that was a valid way to open an event? Is it weird because // is for 
options in perf record and not stat?

>> +
>> +#else
>> +
>> +noinline void leaf(void)
>>   {
>>          while (!done)
>> -               a += b;
>> +               ;
>>   }
>>
>> -noinline void parent(volatile int b)
>> +#endif
>> +
>> +noinline void parent(void)
>>   {
>> -       leaf(b);
>> +       leaf();
>>   }
>>
>>   static int leafloop(int argc, const char **argv)
>> @@ -39,7 +61,7 @@ static int leafloop(int argc, const char **argv)
>>          signal(SIGALRM, sighandler);
>>          alarm(sec);
>>
>> -       parent(sec);
>> +       parent();
>>          return 0;
>>   }
>>
>>
>> ---
>> base-commit: 8c8f2093614373ea8179b562320212a25cf937c0
>> change-id: 20260508-james-perf-leafloop-stack-c221600eddf2
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

