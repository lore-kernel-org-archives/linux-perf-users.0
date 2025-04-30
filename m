Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75922576A;
	Wed, 30 Apr 2025 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055994; cv=none; b=SerU95fp63Sl0umJRBEy4uGN7vyYBdIU46uQLk81NxDuJuXg8RXW365nY7zKdVN5UI2gI9uGtt46ZmBgr5mYBq2+W9shBeXyVcMJTGyJn0wwqL8WueI9TLv6CGuzKIvt+MyLgYvBr3iOn3IQEuiw3PIAaK6O0BNI1uxXoSHFLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055994; c=relaxed/simple;
	bh=Of7a1v8ioLd7B9v+xxJHvaP8wHaUb+cDK43dgVO54vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWiPfG0CCfh5I/LybWLaQOrNQbxP7xEcoKwuMo6EEqmlvRSnrPR3Iee5d11WBx9qngGjjZwz4vN8P7y+xLsViB5v6Xo7x/Px3jfTxGvvlkqruQH+iuJIRb0aW5DlE8OPjvGZTRE8tRlxSt36vllP0V6UGUzkpN1eeeDz4gqiC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIPNgmdZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIPNgmdZ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e743bffc234so333502276.3;
        Wed, 30 Apr 2025 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746055991; x=1746660791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHmEO0fbyI3zWiHX3WZMszxyOKD9Ot7GWFNiX9BtTg4=;
        b=FIPNgmdZbg6qcUNnRCRakrZKP5dnb4iQdBgGF1hUBv4yrX5plZYQkyOl65+o1MG293
         7QNsSGB3JpnX4OQqbmDgI/YoaazrFNJUDygH8ZAKlg6/N4NJzzLRHx79ZP5KDcWCsHeX
         RTxxBPq2WfmIIbSI47wOHZ9CxmD8/m9zPu+2rTIS+ifiuggtu+uZy2EDDQMzH1yt5p5h
         zfcMUwL7FPf/MxS4ufyv7mBJSc4lWhyC+JMpUKTBer2WTnx5jo3nAoxEpYUeiq6ECJH9
         nwx8eZ1kydculiqhvyzn171/s1Yp1YmGSW/EwuVdoDj7o/punjeArpcODRX1+ZTg+x6D
         C0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746055991; x=1746660791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHmEO0fbyI3zWiHX3WZMszxyOKD9Ot7GWFNiX9BtTg4=;
        b=Q/F0kCJWs78GwKHkzhkAgZAXZXaTXz635wa57PkEWT/XlOk8tiEHeivNoYJTdwFQbD
         7rrbS2JyAvt76p/Gqyi1XD26XGOqJCWhLmwnDjutu3QO/VgxhSKTn56P7bDvC6dSknSu
         ZhNcJOI/6Kj5rj/JVbwoQSYhDBF2r9rUJmakMdnSyHj9hAbiRdZZlxHh+JU1mIUOJx/4
         w1wD/yG7s43+ZkdgssWjnnJ5TpPvP9Tjm08oCDwsZHWSqQDRpC8U8PD/BECoibojaXPL
         YzObqQicUiIRoj3Saep6q8T9T7USKLhitr3ETod3Z+zqsgbZOAhZ2cJ1+OfYlteAjAmI
         uVTg==
X-Forwarded-Encrypted: i=1; AJvYcCURPlp8FKclRd41Qic0/18FD77K1wg3kx9F+yBatsL4bm16iU8lUnlMrwN6cFdnkgOMof2mbR0qSqQPiRJf7TolgQ==@vger.kernel.org, AJvYcCXiN47aIEhsDpAzjO7uRjCIbiOxvu9fCR/QW7N95/v4vKVqQSosV0f4I/aK+YGGYXz7vmUx3NjndEpu8dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUt7u9HU6wlccnfy1aYEOKN4A2lt2FrAHZcLqAkEeM2wxfdG5
	PEkqtA1Byn/impEVJGthTaXV/YABSCwiQdolPu+uUrQV1C8YJUnoSnJXhRNjVRgtV/kN5ut9xFX
	G5Jgaq4TF+21kMm8TAZDnKh5E5oU=
X-Gm-Gg: ASbGncvcTtmS1XFKG7zLDKUZFIyjKoi+tNdwDd/eGu2mNk2xQSp8Xm5LwfhgFuDwopz
	zIMG7yF/e5YYWK3EBufxoHmexWj70OGnTSziYbRoS9UrKJlkOCSrio99ISr74pVqL49R3HYc4DG
	sIWxk647Rl1HEy8YU42aRu
X-Google-Smtp-Source: AGHT+IE+O7sLc+C/dbTieCEGPV9NePFRAlH7dGyHFaQHJrFJrMlzCnVV/xs4E60MwzAAVZSm+Zkt5oFCJ5pneCvADKk=
X-Received: by 2002:a05:6902:1504:b0:e64:54c:2262 with SMTP id
 3f1490d57ef6-e75328dbb18mr237025276.30.1746055991146; Wed, 30 Apr 2025
 16:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412015652.245123-1-howardchu95@gmail.com> <b950e80b-5f03-4a06-a393-8fb09b0d9843@linux.ibm.com>
In-Reply-To: <b950e80b-5f03-4a06-a393-8fb09b0d9843@linux.ibm.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 30 Apr 2025 16:33:00 -0700
X-Gm-Features: ATxdqUEKCSNismnacssy8DedfxDfRSUzeCKPgG63lH2ujQW-E9T1AQMMDLbySMw
Message-ID: <CAH0uvohef=2-hE7BBbgNU+OkcY64pZaLgEHJfOq-o+_VsreY3g@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Speed up startup time by bypassing the
 creation of kernel maps
To: Aditya Bodkhe <adityab1@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, charlie@rivosinc.com, 
	mpetlan@redhat.com, vmolnaro@redhat.com, linux@treblig.org, 
	mhiramat@kernel.org, leo.yan@arm.com, dima@secretsauce.net, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	krzysztof.m.lopatowski@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aditya,

Sorry for the late reply =E2=80=94 I was really sick over the past two week=
s.
Anyway, thank you so much for testing this patch on powerpc. Could you
share the commands you used for testing? I noticed a 2-second runtime,
which makes me think you might have used the time sudo ./perf trace --
sleep 1 command I mentioned earlier. However, that command may not be
ideal for benchmarking this patch, as the extra 1-second time makes
performance gain imperceptible.

Personally, I prefer using 'time sudo ./perf trace -C 0 -- true',
tested both with and without the patch. That said, I think it=E2=80=99s als=
o
valid to apply the patch, and test using the following two commands:

# this will not load the kernel map, should be faster.
time sudo ./perf trace -C 0 -- true

# this enables the kernel map, should take longer than the former command
time sudo ./perf trace --call-graph fp --kernel-syscall-graph -C 0 -- true

And these are the results I gathered, all obtained with the patch applied.
perf $ time sudo ./perf trace -C 0 -- true

real    0m0.264s
user    0m0.004s
sys     0m0.009s
perf $ time sudo ./perf trace --call-graph fp --kernel-syscall-graph
-C 0 -- true

real    0m0.462s
user    0m0.004s
sys     0m0.013s

By the way, the 1-second difference in start up time shown in the
commit message, is obtained using an older Lenovo T480, with Intel
i5-8350 processor. The result I gathered above was from a machine with
i7-12700 processor, where the difference is 200ms. And in your
results, the difference is even smaller, which may indicate that your
machine has a better single-core performance, or faster memory, or
other contributing factors.

Would you like a 'Tested-by:' ? :)

Thanks,
Howard
