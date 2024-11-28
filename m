Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC721A0BFD
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799248; cv=none; b=kQJ0HH3AKZGyYdgD/3T/3auL41hKX7sEZZk+p8Sn8LoX8YL8FLTUezYoCy2FFv2i5gm3uHMWl9WWH2jVkYoM4fsYtaRL/TOxCA74hdV0K3HLtyeZhlR/l0i+weuQw9aODBNhqOux5nt+8r5zH+V8kAu7kLdszaKy5HOl1V3oc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799248; c=relaxed/simple;
	bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QF0a1yWU06eYTSeLg2Ayy69nyfW1XEqVzm8kxJfkxzfaJqhNwNH2jynZme6A+QkMoQGgJXezMeLJAwMEuvGnqTP5ujaKVPPaSEC4CE/W2gjY2MD3Fksly+z1Z247B6FMNg9tkh4p2U8n+JpkExUIAg6j6ZFdEb2NWZ7lDYmIci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbC0lIXT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbC0lIXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732799245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
	b=NbC0lIXTtF2aSuGzTE3LPxSIxjRSXKQUiXuXIIdFWW1uKufxb7VXvrAgyV4WxWqRhGraM+
	oGQPEPXv4cl4q1uj7wmW5Bi4Xg4pWnl/rREJataAK92JCs4WmxeM1XWEznA3mwplv1c61M
	ZdRc1c9OOyouCHRPASRNqSUC306Toi4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Qw77KlMTPQK8KSNMOuenlA-1; Thu, 28 Nov 2024 08:07:24 -0500
X-MC-Unique: Qw77KlMTPQK8KSNMOuenlA-1
X-Mimecast-MFC-AGG-ID: Qw77KlMTPQK8KSNMOuenlA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a90fecfeso6382455e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799243; x=1733404043;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
        b=gpAopJPjen61cz9a2k2MGxquX7zD1hdogDaf7YY6YkPXicQ4HaXeG1rcurhQKirBS8
         qb+FHhSPSOmkQn9czao6la9jJkfJ8JFVtIJMGqhb2C0OBAReAIhm2eI5TfPZVrr4iQVr
         ArR5I5Rq+UBLyRZguXvfVA1QEgc8CUCBEDLRIolgPVSmg59jHAQhD1EAw7JfXhaU5+jt
         /q0tYnqyKY1hJXaOVaa2RQOBcEpEObapLYl0Juy2AlyUL+KXELw1iy0B3fLrE3okRDk4
         Y1ZE1UUkXogegM+seDXNCSgH8ED6C4cxU7eL1YQ4d+tIJIPgviPayU2QPi+pPknXISkD
         xNxw==
X-Forwarded-Encrypted: i=1; AJvYcCXLBNtNP2out2o+ADe/04I+tVgt5MwZC84Onxm7yEcLS4EYvdhGIUcwT7AYK/pNKwu2EI4/ei7NwiTKTyE1avjI@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeTPevYjAUrls+9tNyG06YIt4qlbexZGwzX2yZDZGuQ1BI0or
	N6SLiqRQ1nmGEw2wWhxVXLj2PQFZB3PLm2FjZE4JcIWiMpueUdkHEGSnL4ZCSGPMNRHG4yrzjaa
	hQH0bqNJj3c9i+bPEjzjRt8hGutY3tWAcLBiCyoX8WOy32rMWbQv1+wXGIt0pLWpSXKk=
X-Gm-Gg: ASbGncvwCwEnOnbOIEJz3sYeJfemQ393inFg/1fQLKSJ4WB1toqUnudeNDhg1AyI65z
	ee93VDqyoL4vBA37pXzAgnP+jRNIXBvOXqmTI5gAwaEq+mikeSGDAQOPoQETDzfF1AkaoXkj30N
	7RpifrNs82+WAlmLtm1TpbSGMerNCVasP3TaM2IvG1Dinfp+kf6U0oj/MQ90Ht3/T4fQZdAa9JE
	IpSzx55vWBCUFZk0XHVo0TvatiZDBSmT8+n66bN7+jCMiL2AGW2GhnvG7/VEE/Hf64IsfwGMps=
X-Received: by 2002:a05:600c:4e8a:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434a9dc5003mr65339415e9.8.1732799242816;
        Thu, 28 Nov 2024 05:07:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2psrPhjev3bJrjSIB+JHRV7XwXM7FdQVe1Lk4BWmEHa6+pF1hXmW+7huHZUP0OGwp9t/s8w==
X-Received: by 2002:a05:600c:4e8a:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434a9dc5003mr65339055e9.8.1732799242505;
        Thu, 28 Nov 2024 05:07:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd367f9sm1582466f8f.31.2024.11.28.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:07:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D262C164E1A8; Thu, 28 Nov 2024 14:07:20 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Quentin Monnet
 <qmo@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Abdurachmanov <davidlt@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH bpf v2] tools: Override makefile ARCH variable if
 defined, but empty
In-Reply-To: <20241127101748.165693-1-bjorn@kernel.org>
References: <20241127101748.165693-1-bjorn@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Nov 2024 14:07:20 +0100
Message-ID: <87o71zik1j.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=3D" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
>
> This side-effect results in that ARCH, and variables depending on ARCH
> are not set.
>
> Workaround by overriding ARCH to the host arch, if ARCH is empty.
>
> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

