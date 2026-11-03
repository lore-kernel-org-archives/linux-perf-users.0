Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738595;
	b=VF2jr/5M9+TZdeTMBUf06Zyy6iHozrD28kL2O8sPC89cGg6G27ufqMKXRm6bM+iGr0QV
	 FTo9/FkTascvQ4nvwJYW9RuPW/JdSBLqnqDeiGIkvOIzaQfzfIXMxiGU9r481d/VPKhaf
	 B4hZ5gP3voF0HQhct2qQv8kBxMTRAA7NoG7uENryHiWZQ2OkIX4xktO7F4dYo1E6Dl2Cq
	 CDiXEbR+z+Y+iq+LV5SvO+yNpVTOYTBB+fp2eqgxyNKu0jDX4F2HgOzYQtmC9J9pbkDvL
	 IpY6G2vFDl9FwZgb6BGtfaqIcR1S0JkZ19tS1E+VZIHWhN+meSaC4GxcemkdKDnqY1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZPuwe5WEwVxaBVjCfE6du8r1ULexAx9lZ2/7qHxQvgs=;
	b=FiULnJ9Z5PiFuk6RqBS459siKUH38JT17Ne0kLm2aZ93aIKj1hqSVWVA70RfupAxJvA2
	 +180VVRR9w/ftABKLNfyp9LM1yPg18GAb0+ca/1skm3Dw9213zDc6S8rQVnGteyCV4cEL
	 EUPzKDbaUb7NvDWvv6RmNqC0XZHkq6o87jAAjRoLG6sk/QqUQGC/DxZvv/VDh6SOHzXYI
	 9Gv2+C650SoPpn2t2yL4+ROb5i5DDWOMJeoWH4DtX0k+nax3lrWQmySxVdUR8OvDMGdz1
	 8nszZnku1yJh3Rcz46G12wBQtbZxrzR5oSDptGtMh9mZhaOJtIcinfRGOHJtvf/alWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2t3AWXb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A6606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2t3AWXb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC991F000C1;
	Tue,  3 Nov 2026 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738594;
	bh=ZPuwe5WEwVxaBVjCfE6du8r1ULexAx9lZ2/7qHxQvgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2t3AWXb2+9x0FcmCNvU80akFLoYY1yexdEFGT+Msy/FYmGX0PX0F4Pwb8/PSWW+Z
	 l8EW++7SvVP/Uk+0gfDzrKfs43NqKuXpja4Numh1IuZKd0gu0uQ2UbY1luepxzhpd5
	 vVvQ3rGG65fWfuvuttXcXrki8tSCHbR+gw00EulLwxsJdRIJmBWEhXV0qmmk1zmkoy
	 uqZL61qFHuV9DviwTlcvlpPgtv3wRh5OPb3V1uv/gDT7N8JkhLxYnEqGmlA+e9Zu6Q
	 +TtegF1+45rC5erMmgYc7zwKwmgKRZy8eqViMzQiqqHlItMUnuwkzdWlg0q+iQ+inB
	 qwdS5S/lxrNyw==
Message-ID: <sashiko-outbox-196005@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/11] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-6-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-6-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:43:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D6

