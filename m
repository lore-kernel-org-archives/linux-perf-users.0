Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476613FB31
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Oct 2025 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171514; cv=none; b=mXbpYDW4aYVOuzjNimCUjHyaGH5YeWYPeaTwqT4TLrYM4hvR/2/BC5ryeXeT7ZUb54ty4AnWB3gz+FRZwJg1dSMTYWFA08Yob4kRXLap0mD6+hJcJlfOeKHgP+gOVIJwj/1fqum5M5Hmugzdz80I4qXCdKk+LL85L9JxFeoHqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171514; c=relaxed/simple;
	bh=XgCQ9pI6qjLRbY6gYT8jTdFJ43IhBMEiV2kVAMWGn90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hUUf4ROLpGk2A0X/JWlS0TKLCZOUtbmOD/+tpRGskugUk6dKMw9J61vYjxXPtbZLpGDRb1k85dao1IpHj9VhOLFXK1Ovb1kFgagEul8itBIMLIdZzA+/1cmbREJq7I15LLeLu4mGOyHYFd6Zy2ZvKppdWmJHRLxoUYR0A6HOxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+mu330a; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+mu330a"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54b21395093so1893648e0c.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Oct 2025 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760171508; x=1760776308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XgCQ9pI6qjLRbY6gYT8jTdFJ43IhBMEiV2kVAMWGn90=;
        b=P+mu330aSNpI/2ALViKsC2i6zYP+8pDZqWOm6lCCZgoPmZ1VkAw/7eCOvfqBUU0F85
         //kBGn5PhqWz1J3VHhJDHcK7gaY0rzmohHuk78Am4Y0F/d2k8U3JWFR5V1jktgz8XYhJ
         1AwQD9RwD776UMSNoCBcYH1Gi2YvF4e0sXZ2EX8yvi+WrIrckaOOPAulre+Vux3KYnLX
         0yFn4Zf6jo5jokhcnTU9uIbgZfK6dBCMY7jZYChVYxYsuI9nQ5n6zm0tEPa6jofto0Td
         3VHItanKyFbBA5dar09dihgugttJCOlGk+bAyrVmcOxBm7B1U95ce47QBtxaGYdz+c7B
         URKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171508; x=1760776308;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgCQ9pI6qjLRbY6gYT8jTdFJ43IhBMEiV2kVAMWGn90=;
        b=L9bnwbGcDw7oHSV4g8vDFmkYM07Ul+rgX6rGu6R2/Ck5eWDvWqaDbtt6N8A61QIrga
         5Q1CVQQu1xaFaLx/PpG1wBaXCaOqPmBUohh0fY56WBW+dKbYU5uT5dE+rWGh4/S/plcI
         +gbwS9C1IcUe0+UO3V5BkH1om7JEVRIgdX8tRhUOYQI8J4bEqJu/D+/k0b3AvOKxsvbG
         FCkpvG19l9/91iaOvUQkBJjxhN1VTNZfofP8KhUW4lA6UnkBRKgFa0SiizEkH1I7PTuv
         BtRTbMBVThjzY8byFjrCtqZHn9wuxSRzXxk549L9zBEan+ErJcXdhEyp5tuzqIGEws9w
         Sr7w==
X-Forwarded-Encrypted: i=1; AJvYcCWlamtkzxAhzJzo17w/Gyh67gIbjPiLBT7MUWcwJyjStlruVsZslMcS1BUkgcZjWXUmGVBmR9gEnwnrn5fVD2IP@vger.kernel.org
X-Gm-Message-State: AOJu0YzupWvLVg1hiy4BRZjz4xh7V9U9T+cYyFO9zvrkAaAYq+8xshmM
	KTrKw+4YcskVmJCcqDaun6SDhZ6SXy6o0KsbjOdKUuGvsxF+n1U2xHJS7mquaHmklQV8jwme1K0
	Sdd40aPXtJWY1v+km1gmzJKC1Z/wyL0c=
X-Gm-Gg: ASbGncuUyJ1xKZ8wDJBT9Rr40hH/N83kWtDQNt76NaAchOIbaJStTVDCwwapa4nYLJJ
	/08KVwzZ0gUSzSmGBfKnPe1qE/nC7SySYJslofuHWsKxwQXfQewi4bV+Mr92QPtJG4MD7xYgib6
	JP2B1OL9jDHkRY0/1OFhiBaWXG2cGJdlNKUTgpW9ImORtEOHS2gp6JlkTwyAVzF/QLdv+RO4MSq
	IqsVBVmfha+WcUjDVu1qhPYxdAootysoWcc+LJvVKjl1xm26EYARO5bMNQ1LQFSSJ9lPkDRDXfs
	o7ONeAVhWZtHyPKB3bW4vWbReA==
X-Google-Smtp-Source: AGHT+IFejl2oruWpHZ0awY4yEWw3zCcPlWZ16r46QzwtfB7PY9nnCyu3jvPHC5L7g+95uxSL/bKMRFASRVgMxtquJdI=
X-Received: by 2002:a05:6122:a0e:b0:552:361e:25fd with SMTP id
 71dfb90a1353d-554b9193d05mr6615340e0c.2.1760171508129; Sat, 11 Oct 2025
 01:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Octavia Togami <octavia.togami@gmail.com>
Date: Sat, 11 Oct 2025 01:31:37 -0700
X-Gm-Features: AS18NWByaqnuJUTWmTTuzsDkaPpU8PWj6jMDq5RN-D7gigcpvQ72G62InwV-zrI
Message-ID: <CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com>
Subject: [REGRESSION] bisected: perf: hang when using async-profiler caused by
 perf: Fix the POLL_HUP delivery breakage
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using async-profiler
(https://github.com/async-profiler/async-profiler/) on Linux
6.17.1-arch1-1 causes a complete hang of the CPU. This has been
reported by many people at https://github.com/lucko/spark/issues/530.
spark is a piece of software that uses async-profiler internally.

As seen in https://github.com/lucko/spark/issues/530#issuecomment-3339974827,
this was bisected to 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240 perf:
Fix the POLL_HUP delivery breakage. Reverting this commit on 6.17.1
fixed the issue for me.

Steps to reproduce:
1. Get a copy of async-profiler. I tested both v3 (affects older spark
versions) and v4.1 (latest at time of writing). Unarchive it, this is
<async-profiler-dir>.
2. Set kernel parameters kernel.perf_event_paranoid=1 and
kernel.kptr_restrict=0 as instructed by
https://github.com/async-profiler/async-profiler/blob/fb673227c7fb311f872ce9566769b006b357ecbe/docs/GettingStarted.md
3. Install a version of Java that comes with jshell, i.e. Java 9 or
newer. Note: jshell is used for ease of reproduction. Any Java
application that is actively running will work.
4. Run `printf 'int acc; while (true) { acc++; }' | jshell -`. This
will start an infinitely running Java process.
5. Run `jps` and take the PID next to the text RemoteExecutionControl
-- this is the process that was just started.
6. Attach async-profiler to this process by running
`<async-profiler-dir>/bin/asprof -d 1 <PID>`. This will run for one
second, then the system should freeze entirely shortly thereafter.

I triggered a sysrq crash while the system was frozen, and the output
I found in journalctl afterwards is at
https://gist.github.com/octylFractal/76611ee76060051e5efc0c898dd0949e
I'm not sure if that text is actually from the triggered crash, but it
seems relevant. If needed, please tell me how to get the actual crash
report, I'm not sure where it is.

I'm using an AMD Ryzen 9 5900X 12-Core Processor. Given that I've seen
no Intel reports, it may be AMD specific. I don't have an Intel CPU on
hand to test with.

/proc/version: Linux version 6.17.1-arch1-1 (linux@archlinux) (gcc
(GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP
PREEMPT_DYNAMIC Mon, 06 Oct 2025 18:48:29 +0000
Operating System: Arch Linux
uname -mi: x86_64 unknown
