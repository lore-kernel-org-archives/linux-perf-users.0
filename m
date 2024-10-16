Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC375C2FB
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042127; cv=none; b=qTu99yXIwIL1brVzmbOVcL2tOOB0uBsw4qWVYRrwwh5dMelmd4aBzimHYa2VxeU+mzMQGuIVWScDtAYrx8dBCO7sWb75hoOuFQyKgn6x1npAs466NqOYtLsP6U5f1RihiiGrpI54YzQuoru0dNd1iJOOT9uP4xi6wMRvYS9BNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042127; c=relaxed/simple;
	bh=GmbJhR5SkWbzacqrh75bQhObV6r/bn6N82pZsW4ucjk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lXazMe2Hyz6OOxbGkhXsi3pnOSzfjjTSZ6vSfToi1Lml8C+uq0PJNAtjRVLNPSKRS6VSHNZl/mUNOR1dB4EldqlUf4XV1rZpPavQ/7BmaJBLch31NCpfWoWanbgkQuDNIl1/t3RlxfdApHzaoA7rH/+huWKveArlawOS+l0V34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWvIy/VX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWvIy/VX"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e35fb3792eso40510777b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729042124; x=1729646924; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmbJhR5SkWbzacqrh75bQhObV6r/bn6N82pZsW4ucjk=;
        b=PWvIy/VX2u8NhyZq7fs+7U9HNiQvWSbWf43l2+j4mRQ0cudpUArhkmw12DpNtZGeYd
         E68mn6mVmbFpheT7ZBBRT1/M+53rnLqa1TyfshRnM0vdxD8nDGSeiAUMyFRzg9hsEARv
         WLdmqsu1uR0dbwXF+3kPCFk9kb/2nGvcpok+VJKfelJueLuTSea60vMCcbpMGt1KbVkw
         JL5SC7wGkgn16R0201SO/S8cAypPRKk4SFUB+heicqBfr7qiIM5xJm2U8DlqaV3oLlg5
         xyNHPqQkP5+DG5GTJEgronaKnoB+11WN/xu6Fd21IogJHtKwT//yVmJX41TeDlxawu0A
         gc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729042124; x=1729646924;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmbJhR5SkWbzacqrh75bQhObV6r/bn6N82pZsW4ucjk=;
        b=NKa5wjcJIuwdp8c+QprHb6D7HJYe1xMqNZOg78pkiM8xMewoXDWv9V50PvONh3R8+a
         cg83fx/6dunpAqQHiQ94m1IE3qtN/uGEFPpWYDU1T8DrzAkHMnhJiuSHlQMn6oHt9zWN
         k5ptjXTVgz2XEzRPNdgPCeix2AOY4LCv4mZmOJ+EerUUPbDZuIQUBMOnxdr+aMfAmp88
         ZaPAZuWzPbwLwiP8EoZhgLHUXBn+a/H184dV4MRFzroL7gQ19N1BmlxVIne7cf9QnIuz
         Sr4S/+4JcXXW6eGzlKsUDmGRm/DVkOZlHTCYZ0IzvZy11GObd/08TCJRdCuhGhOODeyu
         I/Ew==
X-Gm-Message-State: AOJu0YzOgmT03yJEEkcbhqyPwQ23OtVFXGsmTff8D9nv2hU4zeuZZ9qT
	XAigrw4JfOxV5d/BHgbVHvy2izZlhz03tQWCdfmC+OW3/Wz33eK32Q5PPUfZbSY44x8cAQ/769e
	zf8Sg3T/Hy66tdMcnphIdBlEtXFI4dYS5
X-Google-Smtp-Source: AGHT+IEfbo/13pPDfI08Ag0ht/AZsOPGTcjFoKuO7Zp5YyZJqGK+iJkw5V2JgvlcuFKd8Mt9eJxE6LcSW5J5+okr358=
X-Received: by 2002:a05:690c:38a:b0:6dd:beee:9218 with SMTP id
 00721157ae682-6e347b2dc3bmr143694367b3.30.1729042124560; Tue, 15 Oct 2024
 18:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fengkai Sun <qcloud1014@gmail.com>
Date: Wed, 16 Oct 2024 09:28:33 +0800
Message-ID: <CAF6YOcNRt1=Dgw85QtVgwOY1QYTOd9E=V4Vr9xY2cjZp5n+bgw@mail.gmail.com>
Subject: Toggle perf stat on/off periodically and keep each sample
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've been using control fd and delay=-1 to toggle perf stat on until a
certain point of the program, and it works like a charm.

Now, I want to do this periodically and keep all the results.
Specifically, I have a performance-critical network program that reads
the packets in batches and processes them, and I want to record the
hardware counters on each batch, for future comparison.

Intuitively, this requires two functionalities I have no idea how to achieve:

1. The ability to zero out all recorded counters when the current
sample is finished and
2. The ability to keep individual samples, instead of outputting a
single overall result when the process finishes.

I'm wondering if this can be achieved under current version of perf,
and if such recording makes sense (e.g., does not incur too much
overhead). Thank you!


Thanks,
Fengkai
