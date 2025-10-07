Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27434BA35
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847918; cv=none; b=tcQN/sHNeU4tSXpsIYWJk+nZi418gwQhT6eqeQLfKpv169bvl2YajPDnalXchDspHqODZXyOJJT2VpOqr/lLX1kiMhUcfskop1iwFw3CCITBEYkIxrA5K85Rw3dsCWkeIlYIULJxrMZPx+zh2UFl3vMKUixaKWKQnZE18Ac/1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847918; c=relaxed/simple;
	bh=byJaYuljntQjbWnJ7MXEfy+7zcq9kcAVtKf1rmMUPN0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Y7lHAr9qnArXL0Ec0aQtBgtwofNkQ3ZjIPuGIfVvJYl5fpWfWtUgsazchq2oV3/WZYz6xDJ2d15OolShDzE+cK1PHDesFcIunlYJs8Kphgyk4FOzMiQwREQO3JYPiUwSbdBuUSyWvkMKYmhTQ55HsK53Vd1FQ6k0O4mYOMD0xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIJZfasd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIJZfasd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so38266875e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759847915; x=1760452715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zSIvqJZRNce8mDkBdt82FU5+420FWm2OC/hmlE94/GQ=;
        b=jIJZfasdwCkFaPcpTf4obQddC7+w/uqxIuYhtY46nDrxh2PUFzsWj+J9+gtFNmPkXd
         KzdA0YvjD+zPKnCgt67EF34dGrdItUt5FkF4Ive1ySaBGW/gpTY0VxFJC3XMUFSlZr0Y
         gDg8QFvIbHoBOlOq9ZYi/vvY6xSSFQxqe5AIBJRvtjgCoZKos07ezvAxQQSHuANfsg8P
         UHFLZ3aWMtDasEvCBV59Muv7kl0MqXdxCG0ep1U1gOyYY/OkFQiLyoNaTox7eIHO5x8F
         ecn6pacV0x6iTHl2taorU1RunGyiR6ejKXI1fmHkQ2obkCMd6N01XyiRtoiHemMtP8pa
         rfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759847915; x=1760452715;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSIvqJZRNce8mDkBdt82FU5+420FWm2OC/hmlE94/GQ=;
        b=oY6o8kkRZnROuKP2soHV7OjztZfvJVqmBzRWdwE3RhaK9zabct/i5rD5KhLdnB0zfg
         9j+YpO5zOijNlvNhhLqLV39vCU+AEq6itmL7YOcAFnaIdqIUKtXMvvX9AWUxEN2cvjmx
         8MvjgydZL58fQk9RB8GUs5VVdRAnY60FItNmIJPpYrJjsl8rDcpxOCaaRbZVsKlcsPfU
         lhkQ7MIprEAK54jwRkLtAv954mDYoz12ekGLRiReZniczR1UdSNAgcBqeQFC5WqSStYG
         OyEgas87nEWCHsfSabdF0eW8QpIN+UAqjS5Xwkvg78jnIlHuHPx6k75bBzx6pSX7c9Xu
         EUvQ==
X-Gm-Message-State: AOJu0YxkCs7vPxa2bAD16peVWYPm6Meco5MFw9kfZ1N2NGtN1excLgPs
	FXu09EqvbhBeNxZmYxEX+4fGuskVFRnOAcbGYXDdwviYiF2fWbT/kOGZ
X-Gm-Gg: ASbGncteNbvNhrfvUi42K3CbPcE1y4iftaCUWLt2nGV6IjLiFi4skVnX3u5T9dfk6ei
	ETBfTZzlYVtyqiIaHo3UUpb30lR1MwxPozRaEx0gFf9eUXC+G0oG0ENaDpvj/odZxfK4Kdm6nm+
	cOsKusq9HrD87xA0MMWM0cGb38Eo4jEOU2SPoUA1HJ9hUFflqC6BYdWqC6Sfh/XFnRLTyR37MDI
	yvGuUEl+zC2xHCFuTr9mj/z9U19TKb36v+X3Cl/JZWRq6eoOB8He+2AL2KgsU9IhYmwrn9Yliny
	TEWZ8lq3+rYT7JpzhPZ9Y0WRjYVkt/8SV3PgFpVdlaUv9qEISpJxFujWQu74ky9cC3egitF5ePx
	vprXCTD1M4yRHQS75dbS3fbQYTjOYhHjuhebxEdi089UvTsuJusb/JJRJjDM5Aw==
X-Google-Smtp-Source: AGHT+IH1803nqdV06xICJZ9VRLLsQ8o0CEEecPWFu6K03eh+i8Ny/ReoN7cQCgN1RO5kQZ3OrErJBQ==
X-Received: by 2002:a05:600c:37c9:b0:46e:4341:7302 with SMTP id 5b1f17b1804b1-46e71155b8cmr100829505e9.34.1759847914462;
        Tue, 07 Oct 2025 07:38:34 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.255.129.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4ab0sm25799926f8f.52.2025.10.07.07.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:38:33 -0700 (PDT)
Date: Tue, 07 Oct 2025 11:38:28 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>, Michael Petlan <mpetlan@redhat.com>
CC: linux-perf-users@vger.kernel.org, acme@redhat.com, irogers@google.com,
 jmario@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH 0/4] perf c2c: Detect shared memory cachelines
User-Agent: Thunderbird for Android
In-Reply-To: <aOTMcmg1o2ZWGmFl@google.com>
References: <20251006175710.1179040-1-mpetlan@redhat.com> <aOTMcmg1o2ZWGmFl@google.com>
Message-ID: <F66DD56F-3B91-4FCA-AE6E-0491E9AC72CE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 7, 2025 5:16:50 AM GMT-03:00, Namhyung Kim <namhyung@kernel=2Eo=
rg> wrote:
>On Mon, Oct 06, 2025 at 07:57:06PM +0200, Michael Petlan wrote:
>> Currently, perf-c2c tool has no means to discover a scenario when
>> there is a single cacheline in shared memory, which is mapped to
>> multiple different virtual addresses=2E

>> This patchset adds a mechanism to detect this=2E First, an "S" flag
>> suggests that such scenario may occur (a cacheline in shared memory
>> is captured)=2E Additinally, another option is added (--detect-shm),
>> which zooms to the SHM cacheline and shows the physical addresses too=
=2E

>Any example output?  With a test program would be ideal=2E


Yeah, output paired with a test case is kinda required when adding new fea=
tures=2E=20

Joe Mario provided the gist of one such program, that would be great to ha=
ve as as a perf test simple workload (-w)=2E

That then could be used to add a 'perf test' script to make sure the featu=
re doesn't regress=2E

- Arnaldo=20

- Arnaldo 
