Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF618B460
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347229; cv=none; b=FKwqudqcQ/NoOhL2ln6n4X0ZuWh6nF2nlrneemA9EQtSn175jwi+Hy7b3LP83dBeRipIivI+HXq0W8PJ/oLX3V8ulQ9LpK3oeR6Fd1YdlPRGFTH673pZAmJ9C5qo/zKF3ZiaxZGSceXQFQBgrRe4TkaW+WplvuobCz14IJWJgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347229; c=relaxed/simple;
	bh=t5qwkMzTBR23XN5UHNJ/o9i4SyG0qdSAoujZ77pjNcg=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=G7zDUpVcxVU4y6u5rujdasfC3JUrQ1xDlZv5IEhBA5PSOlbX6QCK7ApzRLn5XnRxYoEjbNi3LmKAiNHyRK5N9fwLu1V41+1gZUFo/jlssUvWOFbwPQ5K5e15EOtqzsHq+YoaxuYrIOtNluXaJ5qhgCo4iYaGsDk+V2GDgrKUTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=E8VLhuzD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="E8VLhuzD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46695dd02e8so1696671cf.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 13:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1733347225; x=1733952025; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8RI6e6ymEr+T+k00/PjhRJ9Ai2Sgn+nQvuCprmberG8=;
        b=E8VLhuzDjeCD/HtceO/cS4HODqYH8iYMviVkYp4hJb4cOyzXe4sE8K+U3JNKo+uSY9
         UVaX8VxoVBzbAmo8cuslIIsXddJFQn3fM86XTulhdLNamIsfPaOS1ljz5+x6/Kq5nXgv
         W4LCyemjSok40ulxDZHdmDwmFJqfkC2Tl4nGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733347225; x=1733952025;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RI6e6ymEr+T+k00/PjhRJ9Ai2Sgn+nQvuCprmberG8=;
        b=DeJqssVviy9Lvcb5np7c7ww1FB/sz59N47nVZZ56oDhqrPO42UnEtMke5mnzzt3gz9
         SyKSdfJIMtRBYpS/FEUyGFPbS8HRmcjQakDOapqstYp9+/dq7EwIMSt7OI2KN29R8hi6
         xOX/VUmNvbCMYl+sOHVQlZcAJNiXnobWqNAQTXGW86Dlg+s175ejPCUUzZDDT72qCiqI
         5dk+SZUms3cl3DLT5BrcYIgoy3Dor0MIbyY7of2Vw+kaLJD2v8j0LPm1yJVwa46MD8se
         Bw6e1Ctv68SswvGVdWtg8msxIrXEPNTUZeaOlUqgVluZKFR0rqcD/6B+5nPB+96VWTUB
         6lTw==
X-Gm-Message-State: AOJu0YyOb3ws1bn43cdrRFLARRvaWgjMiahiRlFT+ZSSjammbLHn/rQY
	xnQpFtWPoRtOMpC2MlQYH1yWApdijPdNBxQMHXlJvFbSHMhoY2O/uMMq0VmYlo4JEC8pNP/c2zI
	=
X-Gm-Gg: ASbGncvfrBHFiPKYWZC9dE1r4Vzl49/sj+8Xf/6x+pmKbsDHyJ6iOyld2t7cMiCnzDz
	4LkY43oZd2GXMdvr9rD2nZDKCN+USBChOsDT1yj6iYfXhejiLWO0qnqzHG4dpctZbTMEwIq8P3N
	GR2Xa/m3Xuv1M84KlgPFbPLbX0jXZniA+1XpS/D6q+xea9GPQTm5jbsBOe3MmI0bXnLTwNfmKW0
	UImW+4B5Rl2AgxgCq/ncG4NJVMvtaEj+2czeEj+KykNDJfV4/dHDz/ZCmH91gdrDwxAAzyI
X-Google-Smtp-Source: AGHT+IGFkkNxj7UuyfHtQW9V/6DpdnAkW+U2fAxDduuIoam8LQbflccP2c9AaLfIMJ9gS76+a3dgsQ==
X-Received: by 2002:ac8:7f11:0:b0:461:9d9:15c2 with SMTP id d75a77b69052e-46717c1a692mr92423571cf.1.1733347225527;
        Wed, 04 Dec 2024 13:20:25 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296efea0sm234591cf.37.2024.12.04.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 13:20:25 -0800 (PST)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 4 Dec 2024 16:20:23 -0500 (EST)
To: linux-perf-users@vger.kernel.org
cc: Peter Zijlstra <peterz@infradead.org>
Subject: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
Message-ID: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello

so the PAPI team is working on trying to get Intel top-down event support
working.

We ran into a problem where on hybrid machines (Alder/Raptor Lake) topdown 
events are only supported on P-cores but not E-cores.

So you have code that is happily using rdpmc to read the data on P-cores 
but if you have bad luck and get rescheduled to an E-core then the rdpmc 
instruction will segfault/gpf the whole program.

Is there any way, short of setting up a complex segfault signal handler, 
to avoid this happening?

In theory you could try to check what core type you are on before doing 
the rdpmc but there's a race there if you get rescheduled after the check 
but before the actual rdpmc instruction.

Vince Weaver
vincent.weaver@maine.edu
