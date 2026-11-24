Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482041;
	b=Gvm2Lklu/qE+eYIHFViT8iydfGV15Q5dg5/lur3HRzSaQKYS5+NzY+5jgMVm3U+Tuki6
	 JJcLNuuR0IeSMyfFhf9nKtiaoMeKxDb0Px3656xO8JvIaaWvPB+d3CwyiXowaeJUlYjNJ
	 SUxRlWH8GRUw7Pa7PDWdUlqeHZpPFhSp0OPqPVX7FkudbLtw7c5cVT9vKCIQg/svJ+YR8
	 orhUATDQ3aJQI4DglV8MaZlNW/OcWjwRSmwoCYUBudco2DEwEa38QLqUKm8kzQhYP/8/Q
	 d2bDp5kmLsN3+a63N2FiAMMfvib5b4zv/2s4MfEe7cU93Q9rdcoMjwkTNRga620wM9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vET6bApxNxm7ne7zpzVu3O5V6fwPhYsOomttYk36AN8=;
	b=i984evbidSkpv0fFVfzdPgfbRIMZjTyid72HfNbjN5RP80n7I6IfkKe7fQeblmaXBhns
	 quoYat0mR6tfu7MdJiLQKR034QTvAJuP8Pz1Id0+MqOcDYA5BkokaczUHwmGLPRprc6Sy
	 6lcanKI7bqP9sInfE0Pjq9OAct7quX5d9jLn38StcIBHA+rJQNiENWTHFVoffNWa88tvF
	 D/WerLxsew6YGRZrgNuI8d67CEoDlyN9ovDMpYgzzIpRVtDzjCY7JaK2wmIAipk698k5C
	 VlmAPV7InzTJEdRpCjCjRemHQndlsimVBWn2UwuuwcDrf9oQEYuR+LqaDGA/t9ET43g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD7fcKIB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92280606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD7fcKIB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1986F1F000C6;
	Tue, 24 Nov 2026 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482041;
	bh=vET6bApxNxm7ne7zpzVu3O5V6fwPhYsOomttYk36AN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kD7fcKIBbKYrlGovDmaKHlookJrtbXV6LPEL3MhewV1TR1PF5Hxk/pn4F1lbv/bV0
	 sQZVm8DiC41JKbGxsJ85+nCnOtST58zMxd6e/lNQcXFnu9AEULDtjkX92Fpz9ycdbh
	 nhTVU6RnJ6G7eoY2CRggJmKvticeZXHNY8gQqHZ7amDqE8ReMRm5RSqjQ7amO08cLu
	 Zrp59G9chDfBOgGZYb1IF1xQdcBhk8soUDVlRAXJ6dWa10upMHDfYk97X257g44sAc
	 KqHLiIx10oiODXSeVgymyW/Y/VMvY3xfAmd24mFYTbi+tyBQaCP9JpZ9vMibfqcQzM
	 c/WoZHDELpkYw==
Message-ID: <sashiko-outbox-230325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 00/26] KVM: x86/pmu: Dynamic mediated PMU context
 switching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 01:00:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 26-patch series:

- Patches 1, 3-9, 11-21, and 23-26: no issues found.
- Patch 2 ("perf/core: Don't subtract guest time for events that..."): 1
  potential issue (1 High)
- Patch 10 ("perf: Track mediated PMU conflicts"): 1 potential issue (1
  Medium)
- Patch 22 ("KVM: x86/pmu: Put the mediated PMU context lazily on..."):
  1 potential issue (1 Medium)

Detailed reviews have been sent as separate replies to patches 2, 10,
and 22.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124002303.1785=
363-1-yosry@kernel.org
