Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622352;
	b=HGhnH/5KKFJEo0aSjjMHeOPDhTaI7Uh4Yh+X8O4WXcycjeNrLg7OYJLd7vhdL7n5Mi8t
	 3IGjIUB60VGUsYIpCbLvqMLT6tZPlsgsO0gvSoC+iM3C02WdOdc9/x+PPfAf6YyRDjOq5
	 f88F/iXhw4SRAlF9B7JCFj5CBFo5nsXX9hYihsm7iToObSVwPmJ07ZNpaQoe1ulLW+BTQ
	 l2i8Q7tStAx4g08AMC225BcIrfW9z778FSUyfx4USEdD2TUj+egdLb2CrAbM6ovje4bVB
	 beZ42B/b2JUHLSxT2D9uZappn1oDeuIKIP100LfYWRM9scKNa6J6tuQDsFdlCoMiR+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qGaR5XTrSKrTMynY0EcXyQvbvdRlgMOekX8cCXQZXmE=;
	b=36/UFYxCA+N/qKHgiGF5b5BdaLV/XbNitMnwFoBf5xAG6eRP41tGWPRPM20H9hSkzsp1
	 gd43rk6YUTksFCdRUnwh+XxyJ9W7qc7yB7pDSLqSL97vuypmb/GsmrYvqq0xZaflY/AiZ
	 BTRM0NNr7rOAyZo2P32wdcR3xlCwSw+7yJx1R7jjgr7OQYaomK1DoWLN7gHsVUyNHBfrS
	 o4zKN6p5jOobyeLcXSsrk/mXprtoKRsLED6PtdBenbeM4AmR0L4g5LKqq714qowaR26Vt
	 8Kj54xqWbDdCmRdMI3gppgfEzqYVqc1Ev+qgUNP03Ho+G9O8DCN4opKbDGr8SNuDvUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SK1hBFkz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A3606A783
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SK1hBFkz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B771F00A18;
	Mon,  2 Nov 2026 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622351;
	bh=qGaR5XTrSKrTMynY0EcXyQvbvdRlgMOekX8cCXQZXmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SK1hBFkz1Qozt6dhiDTI5myb9uR3H5C9e4VstrI6XrNmqttOLff9XPc1flrbgvylF
	 hqDk4auF0kBBoQpQdfk5nOiNOFPTCdcfDEkWAdVlvRnccuruFmBAMlfzeulbNEIRtR
	 3JbfXqTZkA9xWah++9yHq1k2NfXdBiDfnkA4f0+T7IRIxeQlhSeU2TES4oEV7AY+Eg
	 q1wf0lKVshdPA5h/yvCroIFAChAe1vPsPE7yaEVzIILqf2YPD51r39OwasLABaJA+A
	 A+ttguUkj/RilJWVImlwB+4QPRrV8X9p0ZYpyYnu4TrtJvCoqgs/xXFS4271DIwDu1
	 895+KGlzkSOPA==
Message-ID: <sashiko-outbox-193400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/18] perf auxtrace: intel-pt: Use common snapshot
 pointer fixup
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-12-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-12-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:25:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Intel PT has its own wrap search but the same pointer fixup logic as the
> generic auxtrace_record__default_find_snapshot(). Replace the duplicate
> code with auxtrace_record__snapshot_fixup().
>=20
> No functional changes intended.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D12

