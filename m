Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922EF389112
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=64.215.233.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611295; cv=fail; b=qsA1klfX2hXpHS0MSFDB+tOQl0fYjq5HXV/+e863O+SOQ1BgO2QCPtMJ11Rs9qawuC5CjK5855VMTMGrd8o3ZBRgIEsPhXHShj70QgzMbF689QM2l5HZrQMdDqobDLp+wHIv4b3bY3CgRzcAUl9MjqiIXvGAChL6pPAR1f6mxrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611295; c=relaxed/simple;
	bh=9itR/h9LeCqMo+Yp3nTb5IWUh3sAivJNbefaQGffF04=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fDgxBrMQLHSb25hs6bXJKG9n46E4redH5p8lAzIux+Gwj6/xjAmAl1tJolByRY9ZgzZ6lFSDYplCUskoXzc+pGx05ffbf6xdzki53MBw5BPs6XRB56XYpS+irKh58IxwdLlKfu5t/J2X1DkfqKrc+roJc2loUY6o/wJ+J9J75q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=xZlCUmdj; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=j7GuXhdl; arc=fail smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="xZlCUmdj";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="j7GuXhdl"
Received: from mail-ot1-f70.google.com ([209.85.210.70])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.1)
 	id 1vxhAe-00000009Kys-20Ly
 	for linux-perf-users@vger.kernel.org;
 	Wed, 04 Mar 2026 03:01:28 -0500
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4be1dee67so70019563a34.1
         for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 00:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611288; cv=none;
         d=google.com; s=arc-20240605;
         b=TyCvbemU/Ple5nRyxpHZDLV7wcS8ag0hFgehP1WoMqsUkdJFdIYvn9idKbDAEih30i
          PoQ2thvUGyMZpweDplJZytPTqcJJISXSgOTgQzh6FVRJrAPBUNMe5y/jeOZzosb+mSjf
          uhYBGsXpsOaaAe1XTHm4tScwcmDnogF+bEJu2yQY9/5/4vvw5zlRmSkJuVionxViUiRv
          uPcT/85fR4liPJIxQqZdtaJo5JUYIgxj9geJnehhl87RMTgILVxCW9f9rFrLb7JNFHM9
          L0TxDWP2Y8fWBOOMV1xaeJc29grJr6Fz60RPH0Du89k60n1QnBzTX6ISzxT+DgukkXNN
          Lrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
         h=to:subject:message-id:date:from:mime-version:dkim-signature;
         bh=R7fTZkGqmZ29igJIUPte3TlFfsuKL269eIfACaoWgAk=;
         fh=gIcXGLotfzO2ZmnEhSjFNq+ft2UaQ90WGwRr7ybmEa4=;
         b=N9ODzU/6nO8ayPy0vNYoFGhIR47wQfubq4eGMIY1cGvOn5IGu+fxCT2OaCSrdDWcEi
          ZMWNyKtuE5LZ8Sys/ev2aXUJyrplfMlleoWeV3Xacb/+o3LTty6sjjVltRJY3e14DEC+
          pGfuAMKXxYsUUHpiko80OU1zk8pGns2786ISRnMmp0OFjYiAJmJIHeTE+impuhpz10V8
          h2jOPG9F8aeR+4jbzTPOlYHMbdIAeSgVAHayn+EfRpFeh6ohtBtQyd5VT4Qh7tga3/wY
          SRnF1kmC+JcmHmjhyVZqFn+omxonrcCP/fuxfkDIWIs1QL1O1wynYjUkhz7rfzIFdMZY
          YcbA==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1772611288; x=1773216088; darn=vger.kernel.org;
         h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
          :date:message-id:reply-to;
         bh=R7fTZkGqmZ29igJIUPte3TlFfsuKL269eIfACaoWgAk=;
         b=xZlCUmdjOKmg4F6cXYkBBOfYq1hFraqk4dH+umE+jDG630DAJT187WkymQJ94ezUA6
          W5BVIPYgLefA+l0g59KWDuKRZ8mxBl+mHhqK0AZ4zkR3MU9okzkLy8LUWBoIl3QVi6ez
          expo7JqE0xDZalfyOMpDB3Wn8p6bXoyZncNYU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1772611288;
  bh=R7fTZkGqmZ29igJIUPte3TlFfsuKL269eIfACaoWgAk=;
  h=From:Date:Subject:To;
  b=j7GuXhdlDMQ8JqrJfIQEF8To7zM2trzc5mKuTr0Zie198bDzrZCxwLZogd5TTwgip
  TKlhzXz+oxAfJdDauBQwVF+V8IDoiYZx6JTZY2XgYyEACuhkBHztyLrrIGPnQ3KQG9
  1ZWvEI+Zbmfn+jOVOF7hXMo3ehpjy0oa7P7bpvV4rl2LlBeFaqwCQmy9DcfNWXBKQE
  fyAkQQpt9fQBTEfLULwprLpPQqnp5vqPtVf6ycl8k+8lkTFEbu9DaDSD5S2BJTtjMP
  7DPvp7zs9e1m6IqOCsX15ycq/PBO2N4y8UbL/hv9NUYwmB3tvTC9ccQScibcNLmCvK
  rtddPemOgGYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20230601; t=1772611288; x=1773216088;
         h=to:subject:message-id:date:from:mime-version:x-gm-gg
          :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
         bh=R7fTZkGqmZ29igJIUPte3TlFfsuKL269eIfACaoWgAk=;
         b=BGaLrlstG0voMAFrkNvrgPzSMijjBNr6uSFdVYW36C7iMT4H8i8TV4axUwJ0z2df/4
          wSrdLYbAuYFFdSkeXLMO5LLq3zcxTCR59gCn587PDtdqqRveIznwv4fyRV0UaC92LcUX
          RQvWDVdzKR0xK6evO2BKgEz4/JESaGbi/yKsiX/kgA14LOBgpYSTjUHOREGQhQCKeC4g
          Nr/iH3FymXcy9XZLX4wz+I/9xUjweZrFcsOdSASGdEJTgRfq4iVuMPrBEtVyU57b3HnR
          fW4S4VzMnPg3OPRhkQ/nnSz5An9WTZ11r1VP//5niGp+SEmnmijcBq9A5OC2oIb1PGgD
          pcIw==
X-Gm-Message-State: AOJu0YxxMJFpeKPQQ1tU9EdNqThQKNNsUOPqbJlTEyREZSoYXkWMaafr
 	GMM638xtX2wzH7yt7hoSHxBqZvfLGgii42LccUPsAIm7ysRdiRMcPeUOcjh97deE9k8i6yE+iSe
 	BOdMcs1GjZdkaY5sd4fCj9XVuwc+5l5d/Be2eyczj5+/4EcUKDWgmtA+0NfhPnQRQWzOvUcVgaN
 	Bw/0JGX1ZocEj4QRfoau9KRrd0764R+l5WopLbq//Ey77HYlT1QP6UgARFCA==
X-Gm-Gg: ATEYQzzT28GAKyS2quj5g2Zb+YC6nAVpe0QSOaR+DRCKJZs8UWXFke15VpDFNoJinRf
 	nycRm+frFEagtOlL8UwrbOq3GQRZ12DVXDf2FuecC/DhAaKXC66DpjnKoUYwkr8GU1xQoaeTn4j
 	DHwwvhCsK+QIUsHxQWGQOS5rpzKxBNnZhXTvbeGDrS7ByX8P9sGi1iK2R3bxypkCbMaBFijf/yZ
 	Rdn
X-Received: by 2002:a05:6820:160f:b0:66a:1886:e4d8 with SMTP id 006d021491bc7-67b177676bdmr800975eaf.56.1772611287630;
         Wed, 04 Mar 2026 00:01:27 -0800 (PST)
X-Received: by 2002:a05:6820:160f:b0:66a:1886:e4d8 with SMTP id
  006d021491bc7-67b177676bdmr800972eaf.56.1772611287264; Wed, 04 Mar 2026
  00:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrew Hunter <ahunter@janestreet.com>
Date: Wed, 4 Mar 2026 16:01:16 +0800
X-Gm-Features: AaiRm51NeD5hlLETLdOkqQWw2ROxgwle6a_MUGl93EkQJ1pueuOSpRtfTQfZ7aE
Message-ID: <CAOS8N5C+gSubTGww4Fcom9_+OTFTyBPnoBkt-YnG+Nti6F4GmA@mail.gmail.com>
Subject: potential bug -- ignoring frequency for Intel hardware events?
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all --

I believe that there's a bug in the logic for initializing sample
rates for Intel hardware events, and I'm hoping someone can confirm,
or explain why this is intentional if I'm wrong.  I did these
experiments with perf 6.12; it's logistically difficult for me
currently to validate HEAD but I don't think this logic has changed
much; I can look into replicating it if someone thinks this is a known
issue. I did most of my experimenting on a Sapphire Rapids machine but
the basic problem replicates on all the Intel hardware I have access
to.

In particular: I noticed that the sampling rate for
[br_misp_retired.all_branches] was quite low; attempting to pass [-F
2000] did not seem to affect it, nor did using
[br_misp_retired.all_branches/freq=2000/].  In particular, using
strace, with either of those settings, I saw [perf_event_open] called
with freq=0 and sample_period=400009.

[perf record -vv -F 2000 /bin/ls] shows:

Using CPUID GenuineIntel-6-8F-8
Attempt to add: cpu/br_inst_retired.all_branches/
..after resolving event: cpu/event=0xc4,period=0x61a89/
(and a perf_event_attr that matches what I saw in strace.)

I'm not an expert in how perf initializes events, but poking in the
code I think what happens is here:

https://github.com/torvalds/linux/blob/master/tools/perf/util/evsel.c#L1189


case EVSEL__CONFIG_TERM_PERIOD:
if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
attr->sample_period = term->val.period;
attr->freq = 0;

We're picking up the hard-coded default period from the compiled-in
event definitions.  We check that the user didn't pass -c (and leave
it be if so) but we stomp on the user's `-F`.   (Passing [perf record
-c 1000 -e br_misp_retired.all_branches] does appear to sample at the
high rate I expect.)

I suspect this (and the similar TERM_FREQ below) should check both
user_interval and user_freq.

The other surprising thing I noticed is that the same logic appears to
stomp on modifiers passed directly to the event.  For example if I
run:

$  perf record -vv  -e br_inst_retired.all_branches/period=2000/
/bin/ls  2>&1 | head -n 100
Using CPUID GenuineIntel-6-8F-8
Attempt to add: cpu/period=0x7d0,br_inst_retired.all_branches/
..after resolving event: cpu/period=0x7d0,event=0xc4,period=0x61a89/
br_inst_retired.all_branches -> cpu/period=0x7d0,br_inst_retired.all_branches/
DEBUGINFOD_URLS=
Lowering default frequency rate from 4000 to 2000.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             136
  config                           0xc4 (branch-instructions)
  { sample_period, sample_freq }   400009

This I'm less confident of the fix for, but thought I'd mention.  My
best guess is from this line:

> ..after resolving event: cpu/period=0x7d0,event=0xc4,period=0x61a89/

which suggests that the event definition appended a period, and the
later one is stomping on the former one.

My questions for perf maintainers / people who know this better:

- should the EVSEL__CONFIG_TERM_{PERIOD,FREQ} terms check for both
user_interval and user_freq, or am I missing a reason that this is
intentional?

- should on-event modifiers be respected here? Would fixing that be as
simple as prepending what we pick up from the JSON?

- is the behavior I'm seeing (ignoring -F) a bug or is there some
reason that the overall behavior is intended?

Thanks!
Andrew
