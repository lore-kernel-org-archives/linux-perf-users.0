Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B07CA6F
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735701; cv=none; b=rjVBnJarc0/dUllZp2r0hipeq+HRmUvoSY+Y5XvSLKQERJpeOsewodCf+XXsth0qyyl5AL8ooBupvGyUJIPlM91Ylq2QXUeFK+ftU6FQVwrzVxKyfOaBfiMDjbvlXyQGX1b0VSH/lsdV/+sz9KfP7ot1hFvMAoxth5Uhs9RqnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735701; c=relaxed/simple;
	bh=eUZ+Fh4WZtN0NgpyoBv8xQhqDHri3okYFkr9cU9cfkQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GaVpC3WV3RAhkvYUqzfbz/6D+/uxjhMPfUdRktBiECCQYo7oQUYUAwvrv9qtzrlxV52voiyE7ZXFZyFpEE5n/Rtn6Z69Kma8cYNhS7zltgfeRmYghEBuD0wSMCfp1hsU3nc/7ZCAZmz/5ZsUnUm/lnHeSXBkvzCTMre5JDuXQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma7ohAUj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma7ohAUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rUsb9BFjv/SGXtccDr17xh+DnOCZmi7XICMLfPeLdQM=;
	b=Ma7ohAUjqAAnGRZbneQ8JjJSy1H+Q0gMB+QIObw5mo0ndjWBQQY2fMSCqOmUIMo6/b0qew
	sLwoqu232kPDAodHn5cqjpVKkd4CV2IGrb/FfJNktb8B9+Dt1rF04PyJS2azgm//cdDQYV
	1gT2xuJU0oTgaYqujymyu3+DAFCDBfc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-2mnZfxEmNjWvz0WQL9UFwg-1; Sun, 12 Jan 2025 21:34:57 -0500
X-MC-Unique: 2mnZfxEmNjWvz0WQL9UFwg-1
X-Mimecast-MFC-AGG-ID: 2mnZfxEmNjWvz0WQL9UFwg
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216405eea1fso69688805ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 18:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735696; x=1737340496;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUsb9BFjv/SGXtccDr17xh+DnOCZmi7XICMLfPeLdQM=;
        b=Stx1gLDMeFP579ihwOaCfLATOTRivyguT/f32TVS8GaGgueqbLnHwAQXDryLJdchBP
         dj2wp/4ODW3GB3AtuS331s3F54f3iMFICa1rdbJ1WyBN3Gfi37wsehEfHvBvS0Sz5ku/
         mjqf8kW0tDB8hYyoymr4+wrPghgNSvjwGT0awg1gTuOeMGuWIC+syaTarFRgO2VnVjU/
         fbIMkmpj26yUPcfa/fB6OoeZ7nQxzUvyPEtUszMOXo0LssywQ1sAtSBWZH7xWL3fIJca
         SvG8b+nAKVIl89e12da5kMMOP58FqB6R5/snlnZILOHRGaMAtKJ+gQCHm7V/erTdNG+b
         nBag==
X-Gm-Message-State: AOJu0YwbuXGf4Xd2TDb2xfOhhpCUV0CsDz6zAN4pST7BsJPQFJHuoe/D
	t2BtlFlVZNZrBqoDItUcMf9a+CZYxtlnjLcNaUcwsZKMIXMm1p6ZfOMu1ETPmfzhHykelY3oYE9
	O41mYrJXIIE4VOE4RTxsfZuBSCVVFjMjiX5XuIE3hQzA9y6Oj1ZiVcmK7T1MAhFzpZI6kMGdOil
	yEo2vmJIIXRM8dv86NH0MrTCFyE+lL6VcwL9NLkeTKG+V2HwlNf7Kl
X-Gm-Gg: ASbGncvEOEsQb8CRthmvrouJwokqqArMkJZnYPlhTFHT0UYAgUx1xI9sNzM67bkuuSc
	eQg1oWIgTAhTCTCERQlmZaYwqlPDJrosY8ypIOME=
X-Received: by 2002:a17:902:e810:b0:216:2804:a241 with SMTP id d9443c01a7336-21a83fb0a86mr269083685ad.37.1736735695982;
        Sun, 12 Jan 2025 18:34:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX6yxGeMH0ZpEwMjQsCI3I2nKNHzt61e850//2gaREksB2DcbIEnikc9kH7666vlyIa1mxkM5HjkclQQ3bdZ8=
X-Received: by 2002:a17:902:e810:b0:216:2804:a241 with SMTP id
 d9443c01a7336-21a83fb0a86mr269083455ad.37.1736735695701; Sun, 12 Jan 2025
 18:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qiao Zhao <qzhao@redhat.com>
Date: Mon, 13 Jan 2025 10:34:44 +0800
X-Gm-Features: AbW1kvY-bQ7iqyrGo9w9AY4-yJ37b5Otu8Onsk0V_pr2HPTZV39rs1ry-T64FHk
Message-ID: <CAATMXfnhT-Uqp9rfBGZesjYSmbn8UAcyXzuhkhM8Uvg7wCX5Dg@mail.gmail.com>
Subject: perf record "--off-cpu" options failed on 1 [v]cpu machine
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>, irogers@google.com, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I meet this problem when running the perf test "record_offcpu.sh" on 1
[v]cpu machine:
---
# ./record_offcpu.sh
Checking off-cpu privilege
Basic off-cpu test
Error:
The /tmp/__perf_test.perf.data.mjj
FB data has no samples!
Basic off-cpu test [Failed missing output]
---

The command executed is "perf record --off-cpu -e dummy -o ${perfdata}
sleep 1" that can not
record any samples:
---
# perf record --off-cpu -e dummy sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.008 MB perf.data ]

# perf report --stdio
Error:
The perf.data data has no samples!
# To display the perf.data header info, please use
--header/--header-only options.
#
---

I also tested Hardware event 'cycles', and got the same results.

But when test the Tracepoint event "sched:sched_switch", it works and
can get the samples:
---
# perf record --off-cpu -e sched:sched_switch sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.009 MB perf.data (2 samples) ]
---

Can someone give me some ideas why this problem occurs?  I try to read
the code of the
option '--off-cpu', but it looks related to bpf, I have no more ideas for that.

Btw, I tested on 5.14.x and 6.12.x kernels, this issue only happened
on 5.14.x kernel.

Thanks,
Qiao Zhao

