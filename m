Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020393;
	b=j1fmlpeW4uuP8EskQAZ07kMsO94/IC0H3FBS7TXl5v9/rqkTdTBfzaZE2SBlClsGVdTa
	 cGdyWpj+7OQ2ugL28KbhlSLhJ/jXG/CX0LbX19Uqv/TKFfHcRFrEvuraHEND5el9ou8Bf
	 BbCFamXa3hZog2xNxBMbtdwo3mCIk019iXIW8G4Zyqz/oJSMC9kumTAUboTrV5obo/qS4
	 zf59w7wD5ZboOa824ezrYGTURoBIzciQmLgjsYyhOCnIOpP7B8IOrXvx5hQkNmC0mOMcO
	 9XwXHxPljJ7elnksiL81vJbaB/SEfEepkMwpCsXRQYEJZ0Nich7DRMYetxyUtMJtmWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I4nQHWc1gRepvYi2ebEjEYIgwR9gB8LpRDCJlNNzBQ4=;
	b=IRmsqasqbNic7qhKCLvwkUt9iIZin6pDI+fEKH2cYVk4Ponn6m2/0Uh0od1FDAnAwgdM
	 snq3aM0ir40FrsSdiJXay+mJ2DMy3SRYMKqMGta8y4n6+1bxrFBuVVCJmipOS3a2CZQgE
	 HuejuRXQ4+cGnTAZeQ065O6M6C9ZlIy2Nc6gy0HKRjpfYeQ716N9XV2tSqLpUd43IV5rl
	 xnX963+9uX8Y9z4Apxyy21G3Y8oSbhB8w0TNmi6XCEzDLvd6qFG3KLr18AWrXWU814zy4
	 Y3+gWuAwVQREy8fEKPwSuJg3SNk8bl1W4QjVTOD8Aw6YGNa5/Edu/qnUGS9kTEgb2aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsfT9IPS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3C606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsfT9IPS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065421F000C4;
	Wed, 18 Nov 2026 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020393;
	bh=I4nQHWc1gRepvYi2ebEjEYIgwR9gB8LpRDCJlNNzBQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsfT9IPS1zN8+G1W+RBVfIRiRuFa/jRJRkulkzjY0+7cmLZ/an1C+JKadq6ilL9+t
	 yWfFSulw3tGzvoN6n0MlvLU30gwUGrujXbVuENUVbMSgiT+7x9L34KHp7Ksf77Q+v9
	 LWEgSxNWqWcCqzsBjHhRiPtbI3uw33HawnBd8Va9X20y8WiK9+jGIPXOiUzp5oyGNf
	 1yKmsvu1gI9xsOPbxb4hEnk0L7B2jT3zYSVOKMsd3M5kVsXkq/nZOuqUjs682OPuIL
	 ojw2mCd52T1+OsXV9tS5qaAtJGFpwV4+aOMiIScHD9npLxN1AzH3twiEbV2npdryfb
	 w18sCXh8wk2eA==
Message-ID: <sashiko-outbox-221547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/34] perf cs-etm: Remove the decoded packet ring
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-20-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-20-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:46:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Full decoding now stops after every output packet, so the frontend
> drains the packet ring before the decoder can produce another packet.
>=20
> Write directly into the frontend's current packet instead. Remove the
> ring storage but retain the packet count as the pending-packet
> indicator, which will be removed later.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D20

