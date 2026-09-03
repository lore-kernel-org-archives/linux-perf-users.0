Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAF374E5B
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423459; cv=none; b=ZqB9uCX8hOqOdyILy0ZhsEENEl7ky//AErrcTKWa6APMKLz63bRSm+m6j1rqNRurNO17pVBI0fr1uHuMe17sxS7jrBRLSvV1DgjGc1WNI74aDvJQrjlGauQXrpQKXUglzt3vtee7qyKLhiktwd0f0IJTmcn0ojUrmLXCcFXwS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423459; c=relaxed/simple;
	bh=3xTkUkCeT0OZ26EBO1Nx1Qr/EOr0qTEEr0Ied6ZYJhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k+6kKXi8lBgLvdv52VyLlnJzSwV6ArnVFQjVq4sxb7yY7jyqJ5HLUdii/4d7Hs/33u/ZIcvpdemj3W2w8Olbxn+KktIzq0FXTt+//3jaMRoZezfyespzuekbrWQoMmcWDC6RmHLhoJpRWcgq1d64RwxKOoCaekinZZ5KA+uCaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHIcmTfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHIcmTfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECB81F00A3A;
	Thu,  3 Sep 2026 08:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423458;
	bh=3xTkUkCeT0OZ26EBO1Nx1Qr/EOr0qTEEr0Ied6ZYJhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IHIcmTfAvzOjayeigNmbLAgbfV1z/V8AEsesWKsejVjtoALpdqVBaCyVuvJ9RsJr6
	 I8ESIDSUy1A6SBMe6nxNYsDZg0u/QpI0y43Hf+KSy3/sjdq+hVWTmQV+VmLDWb4jKJ
	 hprYqoqpYOwt7ebzgSIDGzf0kbUmIvDByBhhyI5LSzWvnAFmoTmC87obgW81QwjGfc
	 hpKsk0SlhiP4+d6vjdfDq9im45Oq/oFwROdwS0u3ylYL/ipqQAYqadCscUOtQQ+lWc
	 1BjJPjTaWd5NjWmiU0Od0r4LQTVd06xy+cXLaViCYdJAHhr5ScTUpycK/eSE4jlDmJ
	 XI/Z8/3j0Jekw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf python: Fix redundant self-assignment in
 get_argument_count()
Reply-To: sashiko-reviews@lists.linux.dev
To: liujing <liujing@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903081350.4676-1-liujing@cmss.chinamobile.com>
References: <20260903081350.4676-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:17:37 +0000
Message-Id: <20260903081738.4ECB81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Liu Jing <liujing@cmss.chinamobile.com>
>=20
> In get_argument_count(), the variable code_obj is assigned to itself
> before being assigned the result of PyObject_GetAttrString(). This is
> a redundant self-assignment that appears to be a typo.
>=20
> Fix it by removing the redundant self-assignment.
>=20
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903081350.4676=
-1-liujing@cmss.chinamobile.com?part=3D1

