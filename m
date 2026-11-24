Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502648;
	b=5tsgd/7zC/vM4q0fNP8U7xSpJGjvWUpTIdXPtR194vRU5l7NbWNhTr3NHWfLgeUgu/jw
	 i9FJvnC0Vi4hMzu2FbksvbXNTtbNmmOIfOjBRIC1RyoU08xDatoVnf26yD3bFGQf9df6L
	 Bzg/FCwhHVdS18/9dEY7PTCcCU4NbGRisGbYxUrYs/DEVfbnKtjhhEoYIBkVJOsak6ZV8
	 BUngHhk+iDMLLMd4kXKLrOj/DjcMK6rZeWLnh9On8/9gaB7klZDvUAantaCNEXgAcEFZB
	 GvZvMGqLV+X5ZU5t0j9SONIRn7A7YIFeorBXx22G/RI2xMPQISa/dWAyT321nhjHu9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bKlLxg6MKx5+i/RoEKIHMj+VItJ/aIyDsl8nP0mZGEw=;
	b=D4WCygW+ruz8ZUyK0/C4GBxxe2WW2QAEX+L5jGcaxEM69AEnv8E80dWBQ29u/oOLG4vY
	 Jmef0zvgpiWq2o8d8BIwaXxPYTavmWWUl6FIZc+VeY+WZKdnriMfyMtutq5UoU+UCDHqX
	 dAMYQopK66GjN7F5jgTi3Xe7Q9FRD1SzKZISj+2SPud3nou17ioHkUJRoLKuKRjMo316/
	 Mds/qRnYJR5nAd2wDXQqRaywMdX9jOloIOXfuLGoXSn5O89rRe6751kbXM1sxiYzKgseU
	 nNfTWrJPJo9ucCq/Px92eant5T7QcIL85AoFBNKXOjxZkP3HSb/UizjupD+2HP9ErYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3zkwzQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B8606A332;
	Tue, 24 Nov 2026 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3zkwzQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5187A1F000C6;
	Tue, 24 Nov 2026 06:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795502647;
	bh=bKlLxg6MKx5+i/RoEKIHMj+VItJ/aIyDsl8nP0mZGEw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a3zkwzQA+OHORgKTP3TPPG+gu8SRRfBYOt4eb4Vg7g1T6acDAdE7XL03D8BpMoAgO
	 24rmy3GMULMSYSKR6cqGUU9/18vVbkaJQaUWifJJdmcGnpKshn0RHyXY17c72v9tdl
	 BdqxT59wWB8BmqPXq2JeXCvZRii2Q/xwrF+dXX72hoWLMYwzRM0D2Wmwvy9OH/KWyf
	 V+iNM/OIME9gzZK0IdNtX1bsZ475E0R75pbxP0sCjYetsm/7yicFCEcHP0nYzNIZu0
	 BSleG9p1zj3wMSa7LBXkSJZLYVq+rLEEPFjliXKGUqPgDa+FWASH1Ya3mnOTncUzvs
	 0WD6MlXPmhKnw==
Message-ID: <sashiko-outbox-230607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] msr: replace rdmsr()/wrmsr() in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, linux-perf-users@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20261124064108.2440277-1-jgross@suse.com>
References: <20261124064108.2440277-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:44:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace all mentioning of rdmsr() and wrmsr() in comments with
> rdmsrq() and wrmsrq(), as the former functions are no longer
> existing.
>=20
> In drivers/hwmon/coretemp.c drop mentioning rdmsr/wrmsr, as the
> comment was incorrect in this regard.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124064108.2440=
277-1-jgross@suse.com?part=3D1
