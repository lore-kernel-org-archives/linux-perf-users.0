Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049250;
	b=cp4/jdiiHRnMZM5EukIY9VhRqfNVijUo2Htz6coo36Rw5gWTZwOD8ohOJCN3FLMf/P6G
	 USSgFdPiMgWEGAPvBek+jwfq4nYeYgfhA0n6NXwJDF2EYghxrCd1IQ80UNNn12QcUcwKy
	 kWPSVhWcZDWtbRUq4RUUeRX9+qB2W1Mt5OOLNa3l0JQTR9I2B8mI+qCIudl6yjOERZC/9
	 p0TQ7BsevM99PU8pce+y2yN6KYxATFwYfEcQdojFAvApDlHmSE3qWNjRtdO5ERJK55a99
	 1Ea3UjXhqnwbtZ8Wo7p8sx3gMZtxnSBvAep8sYpl03m5F1C6cAYJxhOtBDeK1KzATmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049250;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4KF7Jstleb3wYzLJjnXSn3cSpG2CZvha3VFIe8+ed8U=;
	b=wXBTIFNYT4O6Nc1mDJxw/WWtJFfrzfAwfOoCyx30hUBnyd9OHlUt0ZyZrtaMHSBsQtzv
	 oQ3SL7jwShlJGLKAQ6lJjRPUC2uILi4nCvnO/pjLRtOcIiO4Fs9J+e2gHxNPEsHYoazqO
	 L3iA6itSA0oPhsaadYlTPI8ab/eEIq9RFXLsjmH5vkaq7LVFjp1PronqrRLXOnJzw3hsS
	 2n5PreyZkSHtf1K7p4+EYB9TmqFaw3bCRNuIdYIjUxq/St9ZDun1xGjEfn/VDAWh4Cjlr
	 jShr58nIUbOKpgdaz0KlY5pR3lWQfuEu3eNvjkEaCC0RJYfshzrReVid7tYFyKt+fcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQtxQJxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCFE606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQtxQJxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387381F01825;
	Mon, 26 Oct 2026 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049249;
	bh=4KF7Jstleb3wYzLJjnXSn3cSpG2CZvha3VFIe8+ed8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQtxQJxl3S7SCGduLkOAu80GlCPBwG9+oQo/mp8qLA4QQENUKT71V069Zwhuml6QP
	 yITWbrObOTxNE55s3cSw23TTLME4f+RrEoiByuuLZRSmn7dXpWr3KwHHiD4FHE6FrD
	 d3lWELmkKhOQ3Zaar5T2jn+IuTS8ZAHeS/JdDojFM6x/g/LDMap6ILOtMQLJ5VCI+b
	 PGo4r+S1dlNvlHJkenM5lUR069mweDnqj4kdmbr1XLGZtYEUsmA5SIHqBdHLmfgAuu
	 UCExTRF9GcJInzqgOo0zKhHI6WhPxFcfBtpiF1SnCMS2ikYor08VTNYxX3kIfkNOhQ
	 JNkYNoy/JgL1w==
Message-ID: <sashiko-outbox-185745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: perf: Describe the Broadcom BCM5301X
 AXI PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OkFSTSBQTVUgUFJPRklMSU5HIEFORCBERUJVR0dJTkc=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261026211151.3212237-2-florian.fainelli@broadcom.com>
References: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
 <20261026211151.3212237-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:14:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Describe one APB register window per AXI Trace Module. The counters are
> have no overflow IRQ.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026211151.3212=
237-1-florian.fainelli@broadcom.com?part=3D1

