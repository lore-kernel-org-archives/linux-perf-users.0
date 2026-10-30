Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333436;
	b=OPEnydqm35wsPxHL3bAl07cnA5Tr4aAg6bhBNcmbeA/yxS/lu8yKbF21AZSuIJ6C+6LV
	 Usj3HeJTlzXpsFka2uO7v32r7KlfYrNZqXfSHjnCVaz34h1OjCbrPCinLL38ZpQhVv2DO
	 Epo1b1oZqYFi8dkI/vlcJbK6BTJBfh6A4aXSxkvFcKzhZQV6iyHKH2uv7TBr2oFx1RDaP
	 DlNrhnXjcbjg1dnpUrec43VV2xjaBq8EDEGnwwZFZaGg/a9CaUHyEZGzGi9Y8uCo2mmUu
	 vFBu5npOPLvWAAbmH2g5JFXxrDD14uZKDEpVCSp5bTBFIcLOmLNXCeJCow4d2kqvMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4t2u9EZ+q1TA1uEi0CsiIBDJnomVscXdynDJkXDUtBI=;
	b=ovHph+zAqH6O5ZRaeiZ40KgiWiNpwciIhUYKX9MJRYcufPCDkIGvvXtPDmRd2jYa2stb
	 7l20R7n83D+K7zZYVDx+HBPQKHkmqyxWpV+om0Ix1c0uoykt5rTsso/4/PpTIlFpOjW9V
	 UuV8p1PyIufyke0QrDmQ6DRk7dTQcnPwS9v7QyVcOv/eU9oMG2quAZ87VZZ8a3enGXWDH
	 1wFVJTKOwFfROi0q9DP1OgOauakMMsdZY26484NbJ3P2EQRcXFunGwBsJQAhSTev8juEY
	 PwIYg0dAijdP4wS8a2qLdEG4h/HB7IJoDBl7K3+hMoGmauwN3qxir9PSkY1ZHfp4rrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItyQoAmO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CB606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItyQoAmO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3433C1F000C1;
	Fri, 30 Oct 2026 04:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793333436;
	bh=4t2u9EZ+q1TA1uEi0CsiIBDJnomVscXdynDJkXDUtBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItyQoAmOinCyrmc8yLnXf7Vf4HkWNEkVkq+Q0Xn7OIOED+zlxfOyCitInk5ERKYkv
	 Ddt8pUTdQA4raJRh9e76AZEwrB+PveyKK+kHKMXlIGkfNkjo8brSr5Uq+D7bZbz2FP
	 tpG0Iu/whsfoMFu8O3sSL5nFnhiXXkhaEnRXwF6NN7ZWORZet6xA2SzPiYWfadht7q
	 o6v3p8qu1piXBEcJl+PoNpaiPZvM9YnrqCbXKpO6RSODHgkExMSCvip1Z8Svs4GznU
	 ZXi24ExgLVjg98PKa/1ZcWCvGRxHfsdrYBeODqtRCW3qIL14H/pmypNK1N3ASFzv0Q
	 3aoQqh2lVXM8g==
Message-ID: <sashiko-outbox-190287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-alpha-profileme-v2-4-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
 <20261030-alpha-profileme-v2-4-c702f1c65272@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:10:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A ProfileMe sample's PC alone does not say what happened to the profiled
> instruction. I_STAT and PCTR_CTL do: whether it trapped and why, was
> mispredicted, stalled, or was killed on a wrong path, and what PCTR1
> counted during the window.
>=20
> With PERF_SAMPLE_RAW, attach PMPC, I_STAT and PCTR_CTL to each ProfileMe
> sample in a versioned struct alpha_profileme_sample. PMPC is included
> because a PALmode PMPC is not the sample's IP. Killed instructions can be
> told apart by PM_KILLED_BM and VAL. The 64-bit fields are packed after
> the 32-bit version, since the payload follows the 32-bit raw size in the
> sample record: they are then 8-byte aligned in the record, which needs
> no padding.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-alpha-prof=
ileme-v2-0-c702f1c65272@gmail.com?part=3D4

