Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949A21420B;
	Mon, 31 Mar 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431572; cv=none; b=Tfg8b3fW/Qu0j7oPaXWNwTnG4OJE8shQEtrKFS4xSkx96gL1j3Z+Y0rn0/LE5/FX7VbG+7mCzJHBzL1ZdFF0vmx4x45H+/ForVHjoT6HOdUOSXueZyfHb4xk9yKlPQCgd+57cUFUaksK9bcXhBemZNXaHzC22YQvehc3dlfwV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431572; c=relaxed/simple;
	bh=Qay8wrxRj5qSYVeMowme7dppS0Q5HHS4n7M2e/N2/F8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BJLxS1z0hvWD0KceNLGjEj+v+0gBf6/2oY6PqlaMxh84U4oeP7dmZH7tWUxxIlrIXcZ6QJbXBSmD32iqxH4mdwAZQ1PqRQBCFQmuBOKaALlTrYIT7h2K2JkwwP8dDboSCXVdIXz4TpCZjt3aTQSjr6u3hvfq6Gkh+kaP1E+mfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Kd/sGtmy; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kd/sGtmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743431558; x=1744036358; i=markus.elfring@web.de;
	bh=kmL1aTrcUP4VY6+49eYnRNE3JyhMXnff7+AEBg2a+RI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kd/sGtmyD8kTKpIW3WzIjIdBMIHdTObJ3sqJCTLJBL0GSYEungAl9W/tZ0J3dMxX
	 cpIqJfqZIrW9zrFwMuHbHI5TBnufBWkb6P6XGbF8td4s5IwHLnHVW1UyJCklhwQx4
	 MYrwxb6S1CBQUz6E+5Ll7HHntclipqUBksZEBOIvIpnr3SpF0u2I3JBXR6dG/hRs7
	 xvriqqFR4U2sZO5hx2EmC39htThvYNPHWdRKf5eJUBkqTKeCs1YzxBul/a4nvZV6K
	 g+lfdoMbCC69A3ke3EO6igLJsM/mLS0dEY2alPWNaAyoWYQ722ubZsNqCbUraf4Eg
	 5z15ASAojz0yDae4pQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.37]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1tiH2J3X3W-00ZBYp; Mon, 31
 Mar 2025 16:32:37 +0200
Message-ID: <e617d125-0d04-4f18-9fa4-b0e97564fa85@web.de>
Date: Mon, 31 Mar 2025 16:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
References: <20250331135128.11881-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] driver: tx2: Add NULL check in tx2_uncore_pmu_register
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250331135128.11881-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RIwaUdmew4oY6QVCfkGAwrwsIvc3EyKLbs8QWQDs64QFvYQgi0j
 VsetIy5YxsigMMlj1J+cdl/fyPaNZjjCnC9IH/h33YvfEKr+Ltc1kySDnAsBDtSVb2XfPCj
 v5yNqs+vPVNUnVsZCoS2h7k9nik34SpwCHhJDx3pNC6XJjFxTtgDaUhNEHu8tpfvUL+ZLGG
 TEBPJ85UpFw571ksfcxEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lSFbWzsONxM=;K5cU8rRZmLMrSKm+7oq+u3EqgHx
 BKM3RFzHRM3EuCPzlUsxEnUmFqSqsW3CBS7hu5zf3wSqo3bTIcmMvfiikHK41dkD2m9GFO9n/
 iTzHl/kCGjGppCtpW7CWqNAAxkcR8hI15250pp41GAUzLdSKUVtBli4Bu6AYVJAPEDst6XLmI
 pMP7ekoLuDMDl610x5CeHyZ/kMWeHxEkr2cxZXulo6ArzfLJuElRwl6JfO52S7mJQbKXWsmVd
 0AjmsjaYOhvBAIsRGThHmlQccxZ2wRWK6PBpwnHEm042f0dpzDpbBsD+UdXjfUF3B+C8KlpUK
 aVr5um36YNoqaCjLGn9mjkYoH728pNaRBMjo+x13lmEuum9l5LS708VD5jA3MLwhiJWOOO2ec
 7uRnV9aWymVHyTPbr8JQUIFnDhL+oox5UHmSfsYXlMiA9xRk4GuDPW6Eu6axxVU/KpEcUSjVv
 yEM1Wr8v+XJKNDAUNXig+alHxrb01QPM954hQopn9s8Nqn48cBZbBTEhQ4OAhLTKQHBhKc0aO
 nv9rB/2DQsdpsU7pS87WDUbDblAbTqSiM5hbP88zsDbeVqrTMtkou/AANBeNFxru39gSgLqgp
 7Q6dEi74yoMMzYrrLlzfYwgFZbsLSQInkSPqUZY176qd3DVMHnH99hCHH4On6d7J1U3voooun
 sVrBhd94OeIh5h+wPLEJIaH7b0BZFzg9LzqBjoxXwNcQHGZEdSqZpWdv3atioZZi5CqHire4i
 aCfsvdJxJrVFFU1mSStnCA5NJCBvVYIeJi2F7GKrlxm+AOXT5ZyVjz+CibriG9mBptsSmXjKm
 f/vi7nV4oxRkozkHixV/oRvdNG1X9ZlxXYKSGTTIfVEacb+BBz7gjI/cMh9W2QC6O7nHB03V1
 yb/9chPMbFlTcEDdmfOdxiWVapX2c/qV17kdypLVqz6LEZNG1AcQooZ19o2k1/K2OUZXBWXVH
 OOaHEJHhuGRB3WBB4xmu7fXArD6FLVg4DhXs1v8/LRB8LYddgGJbMIxIaTdPZ2O5SElBEXmvK
 lpq4pe+21M4rT2vgAhhESqqvI1dJIdnJ3mSzWAW+5Bm3YdNF4J00mUy1/lLwZXdpea9tP4KBk
 2quLN03ysmKE4bWyrObIHP5dlQ3PPLrsjqMek0YFTw/haqBwfiooTSivzKH9XKmpz00XkJCdN
 tr5LNWy4yOzvZrwDV+qBW2J73CulIeaLSR41vs6OigHT9BkWihlRZjC3/2KIJWJLd4GMM2h+j
 yh679ynpMvyjBv3UmAEHXf4ANymCY06FjWboxoQ3CLDVhhGVRNbsl1pBF5s3uE8M5IN4AIlyF
 txSmtWO96a3QeDhl15ygu8shvcizKMHLKKqCsLdJDLtcSNcTjfSgc8RnBzk0UalywltDwPT5P
 Qa0QP4/ma7YrKZ6DKfE6mUYJSe0e+PX5QLR8kWF0xQDnO3ueCOQ/Tv3H6A1ep3/2CTXuCoFou
 6J2GYngl4vUuMWru5gW99bUy3rBc6A1sr3rccZ2xDCbLu6nvGGIDkc9iIIZOMlcyjVv9Erg==

=E2=80=A6
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -738,7 +738,8 @@ static int tx2_uncore_pmu_register(
>
>  	tx2_pmu->pmu.name =3D devm_kasprintf(dev, GFP_KERNEL,
>  			"%s", name);
> -
> +	if (!tx2_pmu->pmu.name)
> +		return -ENOMEM;
>  	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
>  }
=E2=80=A6

Should source code analysis approaches take further implementation details
better into account?

Example:
perf_pmu_register()
https://elixir.bootlin.com/linux/v6.14-rc6/source/kernel/events/core.c#L11=
859-L11862
=E2=80=A6
	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
		ret =3D -EINVAL;
=E2=80=A6


Regards,
Markus
