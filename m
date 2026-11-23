Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419888;
	b=MFijaBakZHgYjq3+/NmQOScpdUpklwO7MHpKranUO3LqzzwN9iGJC+1Bh72lhznowrJO
	 urKN1dwO7bTw7zHFSaXua76NI4Wn156DEOhuQhUlZxhyHl5WkVEBqpDgTJ3fRI0lIc2Tr
	 ZVLalW9c3IhffBHHkE5QL0EwYdpDRjgo2GcfbGZZsj/JryjYUgHgucHkV5ZeewZHYAl73
	 Qq/sHmJq4TYj9VolofNw3+vdWU9XdYk21kxNhOww0BHd+XY0X8vtZ4exxMX5xEH9DNEPE
	 Fkx/aRIY2Ax3lBNz1rkn6Tk7cd8ZXf8umR8nCvE+JS3+dCylUCebA8Yate5awQzMwaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419888;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1SP4obenZbrS8c4Kr3VzRbT1nqQSPSfZt3FPQoE34zs=;
	b=SJtaCtCZi1EQblnYPf3LYZrA2+1kM6352GGKQw+VnoWw1fryw41/fYp6ivFAEPqoQ84f
	 yn9vlDLafsSovqT9T0D48Zc5V3F0sQlPsWmW0cPDZ18fKcDXN4/+GDsbuPm5yu1uhV7sq
	 iUmwPfIizlVaCalVtaH/UAg92XIJwSjeDwMC9Fh5ywHvJz2twoYxbmpOhIjDb0vbGsJ5y
	 pVFJpnNSDiRm07QthsBvXoEGnde19qNKZKgDBqNG0bChyLog2gPZdi0Awuw4agV2Zzvg/
	 FboU3wvPdIIiXRkdLdwBEl/+0zULQJBSeNcYChYMAWHJZ96u8E9O9HHum6tnhCsuQRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdjIRtSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C8606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdjIRtSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14F71F000D1;
	Mon, 23 Nov 2026 07:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795419887;
	bh=1SP4obenZbrS8c4Kr3VzRbT1nqQSPSfZt3FPQoE34zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GdjIRtSdSNZ1S34skazxHgZ+Zq35n5sAWXqBUIcRmzXVspt5zqaRL04Cu3vNpLiQk
	 AuYQ5B42Cfp2hIn9bTMizDmtT1tNd5xAJEfc6GTsuj9p3WAXFgzHzVdVOLmQhQ2Ehu
	 NoKCiABj9bEepTF9Y+S0UbwJdB6P/8QuacU6rQkF3hl/OgN7Bd2VMYkXLKti8nPiXs
	 fEqur1Vh5D2p7us7t85Cs77mQZLSdLq1p/fIJy/Ja2fGlYHoc4fUx0/pVuyV6fKLph
	 oxkaA+ZAVQwFOd69rum/vdiI7PO8Wu3/EV4/JfgdgbVlgo521GcFbcZ+e8Smd6pPo5
	 4GVePL3lI+JeA==
Message-ID: <sashiko-outbox-228834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 00/13] perf fixes: off-cpu, stat, tool PMU, bperf,
 and bpf-filter fixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
References: <20261123071913.653315-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:44:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 13-patch series:

- Patches 1-3, 6-10, 12, and 13: no issues found.
- Patch 4 ("perf stat: Give non-perf_event_open events unique ID..."): 1
  potential issue (1 Medium)
- Patch 5 ("perf stat: Preserve per-evsel CPU maps across stat r..."): 2
  potential issues (1 Medium, 1 Low)
- Patch 11 ("perf bpf-filter: Copy bpf_filters in evsel__clone()..."): 1
  potential issue (1 Medium)

Detailed reviews have been sent as separate replies to patches 4, 5, and
11.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123071913.6533=
15-1-irogers@google.com
