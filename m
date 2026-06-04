Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1C4418E6
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576797; cv=none; b=ffxewceZW6/vJ8MCz/CHA/L2lp6WTp4vHNxjYh5jWJS3OICfQQOic0gCXE6pEGaNJxC/vxuvf9fvlOYmvLbs78BfEk7WP4vza/utzI8bYlEdB9JfyF8Ju6yokD6S+eDCc/iPE2jEoikoCkobq7Jhu091r4D38vQ51DnCXLssw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576797; c=relaxed/simple;
	bh=bDJguCkQLLEVAS3+KgmsIucEJ00auEy2Aimrtm0hg9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjgDXkKNupCz9/RLBGY8/E/sUPRTswfHkvBaslrQwHr9GGsAzoTCz7QWcXedhqbz+cJWtkiJp+Q45LPOBQxNziztmMfngqG1GYP4Rr2hSFJOpGCLHbVmAjwzFTzonSOmAumprWUGbIh2nkoNvfCopQa3kTBc4MgFuDTXQZIvMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U+3g4ojT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+3g4ojT"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bef47b1ac01so103371466b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 05:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780576791; x=1781181591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfTI7/RaplkjxzTEP61bDmxIdxLiQtWWBRo1PzCRK/Y=;
        b=U+3g4ojTGlGy+Zh2uVKgmqp+Mp0P9Tz2UloiM4CXUA9iju3Tkn2s00FkGd5XU3G9v8
         JsG7li/65g/KpxVGq8afXeSUWTxEG3USma3QX57qr/qAZ88Z1a0knYvbB7tpzZcH3KfF
         L2p/SL2VWWCUXCqqiqCxhC1+bkawrtxuPGnCZGLnlvfEgfndgkEBzOfcLhJ1sMcdLuQN
         DpvOw3ql6WCDYBD/ixjsseO1QZsIVgmsVvbkLt5U0Iw/FsjLj8ROYhODa1HJoUEech0v
         tWXDGFCdT1cj2+XmfEnYftDZ6v5MvWrjuoSHldQCzE7CYRUwq5pgS1RKtigynrMKzqyX
         IgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576791; x=1781181591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfTI7/RaplkjxzTEP61bDmxIdxLiQtWWBRo1PzCRK/Y=;
        b=lNRKbswXYCiurGsqTSWfhHCAVjDW463TYFK6BumlOV6BA1TFz8Firk0UURgHMjK2S5
         i9eaHb/X2kfZ+eDkW1vWugLp5+KeAow3ShNjJIaiLV9yjOu8euTe/qfGcyRdA3xdHqFa
         F+/OZ9dQqhCMSI9oWvhnzEaGimruW1HVf8yydfkO0qK173d3MQqkse9cEj6HXQJ4PYY/
         9ueQGiL4mbDd3zy2ZgFDFVz67/sPljDFHs/NvoG+1AR/KYthfyMU+kfW22iB8ss4tLWl
         1Sf8zSuNnq6kvCFqEKMom9nv7D/zuUADQY7iW0jcV5Xm5DwtZV5ZFyULKOodrB6JFLGs
         NlSQ==
X-Gm-Message-State: AOJu0YzNnjFGudaoVRXXlnwyjyMEN7m0tJ/eu3EfWG5ybJj1c2Xyn09w
	EzSQ6nA8ej8wNvHTos1JT45UVCgiDfjuINPaLA2AK6haByW4TRsOEz1dgW7SX2gI8Y8=
X-Gm-Gg: Acq92OEG3cpEqQDfHwVLUXzzKq8UkQn3YH14F25nMnfqYbsLBpoEB44d0++jbVVS5HF
	PWbkMAxTs9yGr1DS0dWYeS/Y0MSKs75NnJ9Rpx42XWnYJhsEzGEorBw5bukciH/yIXUmVHqi+p+
	ByynciscU+5SbJy3LhF6eaqhYRFU2EdoktpJnwYOVMFPn7zaJkSnbQ4riRsvrKiade3WzT5znTM
	09jh1MGAzq+tk9dBk6pwyK/ngJ4oHY+/YLNDjoyVUlaJVT/aqX7ypMp042szzkgI5CyVlY0SYOT
	vUP8+JZ0O2d86eyu6nv8XtD7TKQWDQmIJbH9ZGj6MFIcawdTfU+x7BLlZ6tnzfD6rqRFQBOzWln
	x5eQ+fH8oEbq43u8SeJnxPVDY9FIDbRkeJ+w13HCUOjCmoWP5wvB4jHM8jw1+5IMNXdTeXJy+mN
	ofl+vTDoLArfo3X11DEOIuO9QQ7rOIq8BIhtZjDZk=
X-Received: by 2002:a17:906:4597:b0:bd5:2859:ed0a with SMTP id a640c23a62f3a-bf0af60a732mr277844766b.42.1780576791060;
        Thu, 04 Jun 2026 05:39:51 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm7660350f8f.30.2026.06.04.05.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:39:50 -0700 (PDT)
Message-ID: <d4471acf-207e-4426-a1b9-a17ce14241b1@linaro.org>
Date: Thu, 4 Jun 2026 13:39:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/19] perf test: Add a workload that forces context
 switches
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260603-james-cs-context-tracking-fix-v3-3-c392945d9ed5@linaro.org>
 <20260603102817.EFB021F00893@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603102817.EFB021F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 11:28 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Calling exit(1) on I/O failure in the parent process abruptly terminates the test wrapper and bypasses workload control cleanup.
> --
> 
> commit 4bc96eb1d44f39f8252cd4bbe7f402600bc7ca26
> Author: James Clark <james.clark@linaro.org>
> 
> perf test: Add a workload that forces context switches
> 
> This workload launches two processes that block when reading and writing
> to each other forcing the other process to be scheduled for each
> read/write pair.
> 
>> diff --git a/tools/perf/tests/workloads/context_switch_loop.c b/tools/perf/tests/workloads/context_switch_loop.c
>> new file mode 100644
>> index 0000000000000..173d770ae6192
>> --- /dev/null
>> +++ b/tools/perf/tests/workloads/context_switch_loop.c
>> @@ -0,0 +1,101 @@
> 
> [ ... ]
> 
>> +#define write_block(fd) \
>> +	do { \
>> +		if (write(fd, &buf, 1) <= 0) \
>> +			exit(1); \
>> +	} while (0)
>> +
>> +#define read_block(fd) \
>> +	do { \
>> +		if (read(fd, &buf, 1) <= 0) \
>> +			exit(1); \
>> +	} while (0)
> 
> [ ... ]
> 
>> +	if (!proc1_pid) {
>> +		close(a_to_b[0]);
>> +		close(b_to_a[1]);
>> +		prctl(PR_SET_NAME, "proc1", 0, 0, 0);
>> +		context_switch_loop_proc1(b_to_a[0], a_to_b[1]);
>> +		close(a_to_b[1]);
>> +		close(b_to_a[0]);
>> +		exit(0);
>> +	}
>> +
>> +	close(a_to_b[1]);
>> +	close(b_to_a[0]);
>> +	prctl(PR_SET_NAME, "proc2", 0, 0, 0);
>> +	context_switch_loop_proc2(a_to_b[0], b_to_a[1]);
> 
> [Severity: Medium]
> Since context_switch_loop_proc2() runs in the parent process, does calling
> exit(1) on I/O failures abruptly terminate the entire perf test wrapper?
> 
> If write_block() or read_block() encounter an error like EINTR, they call
> exit(1) directly. Because context_switch_loop_proc2() is executed in the main
> process rather than a forked child, this bypasses the workload control cleanup
> in run_workload().
> 
> Should the parent process return an error code instead of calling exit(1) so
> perf test can clean up gracefully?
> 

Will fix.

>> +	close(a_to_b[0]);
>> +	close(b_to_a[1]);
>> +
>> +	if (waitpid(proc1_pid, &status, 0) != proc1_pid || !WIFEXITED(status) ||
>> +	    WEXITSTATUS(status))
>> +		return 1;
>> +
>> +	return 0;
>> +}
> 

