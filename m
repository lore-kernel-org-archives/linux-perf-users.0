Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40450534473
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080402; cv=none; b=dAmvur4iVABG9hjnsh40eFzlIOYFzn0KrpGpdZG+KbAsS5ae4BOFaQEz9UucjHWr7pmo/EVzWH0XLqDURx6HLHlepxL03PrZRUbq18aZyj/VHYwLA3CXnSc9blSz0/j3pUX02h/VatoWjx9RrICLfJxvP6XbZKQI0HhzUnvczZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080402; c=relaxed/simple;
	bh=MfOQfoDL7vwjcLZoRJOknENsJ6eQVvjlFMEQ7WzjbEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GqPCrEfftyB6YU9clZhmkcJAasHlFU4J7MLr3fNkINNQ0Wm0BwsjzZ/tHW8UV3592rGf79AunUeEN8P3PJbNA9oXyVUL1GoS2oowQ6kVJYgiqbtzXYkU6AQuxHzLPakkjW3N8Lp/eiRnB328CCGiPiOi1zeidnimN7xHkQDjIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQuMJeuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQuMJeuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEEF1F00899;
	Tue, 22 Sep 2026 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080399;
	bh=MfOQfoDL7vwjcLZoRJOknENsJ6eQVvjlFMEQ7WzjbEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQuMJeuMwMmiDTxreApKMofp58M+x5f/SCxiPc6bDZjBmOeLSj90gqc4+5rh8Ipij
	 nZjF4x5UaaZBW+4D1SMMV3SmjgAuzEz/IpDdfT/NKgVMpx2HLaTEUZwUW9f5/pqnRN
	 h8MELHE5cRLhbmpcUycqJuJsBBJB5nqgdJjYKCo81/mDiFQiRYS97LDMgfeHbg3K/e
	 1cMNUpqh9XGaGF9rCwyE4l9UMXeyX+miLRJrGvM005S+/DK5wHVNbGYhIHkq7EuD9i
	 zwGwtF2QLPJNw3GxUHa5nz5PR6xub0xXGTphBCM/xcLjYedxcsIIAiCufw3iHkKkoA
	 lotVBn5sOtbPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] perf annotate-data: Bound the member nesting
 recursion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922122623.1029132-5-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:33:19 +0000
Message-Id: <20260922123319.CCEEF1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Members are added recursively, and the same kind of broken DIE can make
> a member's type point back at one of its own ancestors, recursing until
> the stack is gone; nothing usable comes out of nesting members 32 deep
> anyway, so stop there, marking the member as truncated (reported by the
> JSON exporter added in a later series) and giving up on member types
> that don't resolve.
>=20
> The limit is checked where the children of an aggregate would be
> expanded, so only struct/union members get marked as truncated: a
> primitive member that merely lands on the limit has no children to
> expand and is reported as complete.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122623.1029=
132-1-acme@kernel.org?part=3D4

