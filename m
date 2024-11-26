Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BB8831
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659230; cv=none; b=g+DFZvwmWoRNXXMorEGpiYaTsaf59RRHN2Y8rqM7WwQB/pAdYu4ZtwVHZthVKMuRGtS0Vn130WVGxKi/uz+6l1r5KjjMlfsVW6OM5CE1Wwwa/7HJqDgW5Boo3Zig5jRbQJoCieyaN4HuWTiiVmAAucsg74NqLdF1Jw3ClTb9tbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659230; c=relaxed/simple;
	bh=taiOxPz4auFfF9OuAUGHYzdv/sSg5fLP6wEISmFWhPo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q8dOun55jba4/ADX/Xe6lqh+mXA2lXVqPECK0rYLJa+hYV88WrbtiTX9Ir4gdtZ2Lbaryua8J2IoqgwQwzUZodLDo7b4lyBpXTGqHOkkG73EyArVpohey2d3DXADGVbbSRod3pFOyDJ/Q+ey/qlDI6/pX+ZuqqkIXS97y4bio1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=cWLHgMtw; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="cWLHgMtw"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46690cbec70so20387501cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1732659228; x=1733264028; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8vnet+jZUHVtbZiOVIfYJ+cqQVDEOSc7i4QhcykLOs=;
        b=cWLHgMtw2ZV+pIwXIG29W20tEgSm/6X236saPpvMJjnVSQusXq9fVixgljgKshWurG
         vmMOToJ8vWZPgP5AxUrLSdxspVdm7G3RyzSP0tsrGMD176GqUXLaPk1q3RNYwBi0YuBO
         4qKdQz9ki8LP14RoExZekXrXOaiyIvaa7JNAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659228; x=1733264028;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8vnet+jZUHVtbZiOVIfYJ+cqQVDEOSc7i4QhcykLOs=;
        b=PUld8APWn2yHjmtQ8rVLU966v78ArOif9/tZe1T93vZrbnMILYlWpKRuPod4vyAt+v
         jlVwU60QRzUbSvmfC4dpkvPlOMd0u3TPoKopmfDaCjryhWY3/UFt8cOH/c6zoGBaeo3W
         PmjEXqe/FJaF57Njbbl31QDWA1uGUsSHUeqG1j10twwBEufjRm1qm/RV1JfXYG6iyu5s
         aybW2Y18HXkRPAc8HTKL7md4i+olAHqa/nBhgfillfhz3UEYPUL9ETqa6YBLprth0Dnn
         sOI61x8QGByhMBW4BnucKFXdD5xXvgl6SeXnoDS8fd4QV/EwNPFIKLRQGX7K3QyUdkez
         RE3w==
X-Forwarded-Encrypted: i=1; AJvYcCWCi4Xupm88SUcUP+jQQ77bMco/NWNO09kTAc2SnOo4bCN93Km79lcP2GdJu+1DpRHm0/QQeqNHBxLuJDxikqyr@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTBJzAmP7BYEf9qAZgsjvozzYh2t0oqLta8pwCFGcuFHv86my
	MjlHWdj35OupF2wnoHgvOR/NH4d09gw8Catr6PshJVXBovlp/tTaLvDkCWBj8g==
X-Gm-Gg: ASbGnctaOhG6W5req2JDxPZP1A9qa9Fs5PhHfr6q+0JQPH0yQREf8U8xD3MFyTHK/td
	Tm+e/4OaiMpMMBWXnsbX4tewKWQqRv/1JJ6V8TVTbHpNMGPIKaOspfSPuBCNn+nRIdUR11LBt0m
	oFfTddzWK9sRhW1gyrkbh9nGFLUJAHKmqL8esVKaIc6lvMfoeIatKnsR1KlFOpCUR1vKyXuS9vv
	Tr0wF46tUS3OLqqZiKC+MyzPH9H8kGVKG4C1F0yIwN+bV0tl4D5GyaBi2yAebAMYAi8O1W4
X-Google-Smtp-Source: AGHT+IFB8EjeCvd8p/S9ybtXlr5lQgvIArr8w8e4rrRFHmsDecOakZA0PqppF8gLye0+x0vQpZ7ADw==
X-Received: by 2002:ac8:5d54:0:b0:460:e593:45aa with SMTP id d75a77b69052e-466b357ce9dmr11812211cf.33.1732659227830;
        Tue, 26 Nov 2024 14:13:47 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46693dfe536sm29682951cf.8.2024.11.26.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:13:46 -0800 (PST)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 26 Nov 2024 17:13:45 -0500 (EST)
To: =?ISO-8859-2?Q?Miko=B3aj_Ko=B3ek?= <kolek.mikolaj@gmail.com>
cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: perf_event_open.2: mmap ring buffer requirement for receiving
 overflow notifications
In-Reply-To: <CAHGiy68y37n-y_b0gR-dArxFRzYOAr93dCw_6bvkNReNWQ37Hw@mail.gmail.com>
Message-ID: <00910b8e-fdaf-45ae-8dcc-8c926d7fce65@maine.edu>
References: <CAHGiy68y37n-y_b0gR-dArxFRzYOAr93dCw_6bvkNReNWQ37Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463802360-1841494558-1732659226=:2159556"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463802360-1841494558-1732659226=:2159556
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 23 Nov 2024, Mikołaj Kołek wrote:

> findings. In the MMAP layout section of the page, you can find this
> sentence:
> Before Linux 2.6.39, there is a bug that means you must allocate
> an mmap ring buffer when sampling even if you do not plan to
> access it.
> Unless I'm somehow misunderstanding it, this statement does not seem
> to be well worded, or alternatively this bug does not seem to be
> fixed.

That text was probably written by me.

I tried looking at the 2.6.39 code, my perf_tests, and also PAPI which was 
where the problem was probably noticed but I can't find a firm reference 
for how the issue was fixed.

If I recall, the problem was if you were trying to create a sampling event 
without mmap (say you want to get a signal every 100,000 retired 
instructions, but you don't actually want any sample data).  I think 
before 2.6.39 if you tried setting that up you'd get some sort of error 
(an EINVAL?) when trying to start(?) the event.

It is possible this wasn't fixed.  I tried to be pretty good 
about putting relevant git commits as comments in the manpage but there 
doesn't seem to be one for that part of the text.  I'm guessing it was 
PeterZ doing the work on this so maybe he remembers.

Vince Weaver
vincent.weaver@maine.edu


---1463802360-1841494558-1732659226=:2159556--
