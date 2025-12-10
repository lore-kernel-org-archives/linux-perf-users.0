Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BA136351
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765391944; cv=pass; b=TBIHRZI4tHE4Au9zgdtLAbhqRlvH4ab3PIVuQEc/fB5HZq7gJ70pFFmsf0EOqTXuBUC0bzX8SKChWs4ico2R1DhPUinE408jvIqGVYvIQnaPrnBjCQSsI649Z1D8atXegqcQio1t6IXc+SQ9Yv0PxSvve7zizYtZuRY7UTH3Cxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765391944; c=relaxed/simple;
	bh=GXByxdqbshboTWkWfzfyHgJ1p0lHhn/zWGU1v/M5foI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw6K0jQYEEoNgxcpJJLn1rOgYTDZ0uEWuYn+i4JEWRZ6ZH4+kBQXi2747lcrkec7ylIldb70C4weniiubEERf9CWJxxFcyTkJXDFOhMUXCKyXoowIGMMa3fYH/UU/ag3VKDUgPgG4YbQATj+h/pLrdl6WcMJp0DbNMnom84rohg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yDR5Sd4m; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yDR5Sd4m"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e13bf404so15995ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 10:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765391943; cv=none;
        d=google.com; s=arc-20240605;
        b=RDqO/upibMbAQuNT0St4cfYJPLQCSMQ9XIpQ4pHDfGKgRFH456R9sez3d4zDEVsJf9
         TkZ/1cp/4nBv7RE5cbWkmBIlXMGbvwkasg2lTGS7bbiFeNv7utDO2NkqP+tj9zfwRTd+
         CPwtldsPJSWynMRHdoYiZ3avlP43BBzwcgEvg88ok1DDomIICqluozogfLK19hPChPO9
         7xmo4HsbekkdHBjYSo8Rcu8SkopuVHZ2hWcZXKu808HTv9R8DMGPrh7yv0k6qhVkyHS8
         1/ASz026erY2tToWSuzfsnAuCJUAJVwZ4Y4YUiFVUrQy/1ipK3F20yJMwjP9mFcK93B8
         roGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXByxdqbshboTWkWfzfyHgJ1p0lHhn/zWGU1v/M5foI=;
        fh=n74jQJiCJ1kqDa1g34gHV4UtMdkdMQvZ4Sjj0nUwLdA=;
        b=LmoQUJh2qdk/pMUl/8mGT7cacOvc89SIoUJz45GiX3grzHOWcaEgw0k66FayuUTIsT
         o2c6Hkd1rA7hmvRy4FLF6SYiGkkPR+LCGpagkqszHDix9h5iU4ph8y7g1oarPXaCTc6I
         U+Z9n8gm4olue2Zg8BQFlcbg98E0sC0XbH4mX98zCVBDAri/8Z0iStgnmYNpa11WNnFe
         8vtbdkqA4MAnjy6X0Js6bghpb3mRhyINgFPpl1rijFMnUtrWkLNuMr5m492y4Jn9nMz3
         ocKjSfCwV/umcyHtdMeh+2QLU/KCmBeDE8MGMbS4J73ddbQVkMxqWGSRy0Og5irG1pZ5
         4eDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765391943; x=1765996743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXByxdqbshboTWkWfzfyHgJ1p0lHhn/zWGU1v/M5foI=;
        b=yDR5Sd4myNYT14FcdsAxCiMOKo8UlacyO0+tZsP6JwOdC9GiZug53Gsi5S1O2yxPgK
         boAbOoBaSRg4hjjq64lzlYLrTJBlwTsx60dZ8ebB/EjxvLn4FCrSonncGIowhUxqFUDk
         sFs9NCGiamBvgA4Rigy6mwiOm/ueSMlX5omnC7q1NhnFg9hlswqbp1Be2HA13QJLR8Ux
         6Fd99cL5ucoeWHs2Ztuu0N3hee/PUnqsme48bHShWOdBagTFY/hkxnmyo6XFrC28jA1h
         Id5KBxuYq7uV2uyp/HT2Jby1dy4cDhmGgd123nUNGo7bJ1AYXYFupPHYYCgdUCEmFSJw
         dvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765391943; x=1765996743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXByxdqbshboTWkWfzfyHgJ1p0lHhn/zWGU1v/M5foI=;
        b=s3Ax0cl26KIHOWu4ceFsTEiomw79YI0K8nY75WUuzQrZhSiPbu3DDoPhDmJT2Iph0B
         b51GLMVeAbvT6MYDVp7gu86y+ItcOHX39lCgk0l4zQo2WIbREt5rELFkJvBJu8hrR01k
         tUIh1kvu7BE6CNn05fksc9OYY8jZ74J/7iA+0Bbhonep6D8SdLtYW7cOlnKiunnhmB5R
         NNLtjuOmv02XgyT+MNiIpULf60UUI+6Lwem7aYartUbkwbgldNQ2R2WfR/zpXlWkH8sX
         1vTJdahEmN+pfchd/tx9w4ysyMIdPv7SGsID8eggSh6QZHOg7btmsUEYNNrwVe8/8tfe
         iLag==
X-Forwarded-Encrypted: i=1; AJvYcCW5izMPCeoTBc/24aULaoNVvSW9JR7atjcuFhDSiCD6rOMqeKAwuhysIR/MO1D/ukGx21XLgO8pToE2u6RbAalf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xVfg7DtU87iQfFg3VmRgcVFrnrfhp3MBNhoMDYyhPnZ3cxmo
	e3XAhRJqfNpnUe5+5GPgkJK+avpZwDkKkhH1rPKd+pQceSX6/Mpqke/KuIreKq/XVUl8haGkZP4
	zP5a57zGyqym6UiQfe7SAvbANtY2d+7xIyU1iMZMr
X-Gm-Gg: AY/fxX5JR4CzRHMeN19JrQDvLkA4N8meLO6luXaXBIePaDpRr2oFEI7PcqDALQeagKi
	MR9eWzFIIpXg5uIuEVH/dF9QNjgFJJYnVy7vJhr1yCFeoFYGB6GMWz1L08qXqW4WrMgiJdSnPmR
	+VBgMI4uSkq3pB4it+pI84CN1SB4NNwD60VhowLfUlaCxaHetpsSRscnpxJyY8DPav9H6M2t/F2
	QS4kf78JtANmda2gYMQr0Xk4zqzW9K/kkhkg+BNIzCIjsKPs0RtzKYNR+Y2bTpdfMTY3r9faZW5
	mPpKkFFPNr98n5u4kKscGLyWO7IPeWiMsePE
X-Google-Smtp-Source: AGHT+IFRzIABOIYCbEyDQqye9vn1iBq9cOpKHfgWUHyxulKgprvrEpUzR1LUvOAdXoCBcyt8e3A6i0aZubKGr5CxFhw=
X-Received: by 2002:a17:903:2f8f:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-29ee9dcb749mr131115ad.6.1765391942178; Wed, 10 Dec 2025
 10:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
 <20251210020026.3265559-1-sjayaram@akamai.com>
In-Reply-To: <20251210020026.3265559-1-sjayaram@akamai.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 10:38:49 -0800
X-Gm-Features: AQt7F2puvhMg-gkZV__rKcXVpnreHh44yHRbYGS6SCqJBUSmsPJd5ee3ryPvslk
Message-ID: <CAP-5=fVmbif0k3LMnMMeZUPnyL5fG=fNc-6TnBsXmhzqHu=0gQ@mail.gmail.com>
Subject: Re: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
To: Sri Jayaramappa <sjayaram@akamai.com>
Cc: acme@kernel.org, amadio@gentoo.org, johunt@akamai.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 6:00=E2=80=AFPM Sri Jayaramappa <sjayaram@akamai.com=
> wrote:
>
> Hi Ian,
>
> Yes, this covers my case. I had thought through other possible scenarios =
before sending the patch, and I don=E2=80=99t see any additional issues.

Thanks Sri,

any chance you could reply to the test e-mail with a "Reviewed-by: Sri
Jayaramappa <sjayaram@akamai.com>" ? It makes it easier for patch
managers to spot that the code is reviewed.

Thanks!
Ian
