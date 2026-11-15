Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707672;
	b=UIjE0I396R3UaajIC/dXCEDovlp8gIiQxvaNHHsfE7PFLsQKG8p+Txgzu6Br8dpXe8/X
	 5me2XEWa0+6GCFvJAkRS8GZqNxhE3fx1dOX7nbwLtC/n67xYWah3Ux/ZafuGJWsbey805
	 4J72Ha4ylbaA/btEsM/cXovJDAXnBOmefjWDBO4LJl2A6OZgSyuk3/UnLMJVXIcx/AdDf
	 nQ7NOEcfkgfKeudiSPBcLg1arQZ7Azh29cXImBVjAVcrRBt5SkDlGLRE53zapmppOMw/T
	 IFpKKyRAjO3NF/A9Tm8LfPibAEIN1S/dTZwJIBX2kXM3BCbNkrQVdZrg7KitQy342TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707672;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g2mPCAiCLDND4z7jmAW8uIDcPP4RBQZp0wiTis4ym2c=;
	b=VoUoYcDGjAlXDTTPfH1QkjSyEuOEaDSJTo4K8klS+UkAdZQanlu5Znm15MF+oxqKfYNV
	 ZwvkHr89zKhqZFVoI5+0Fihv6UMzMEj5NRmIaY6q6BYsU3sdRozlTWQdT5pDGnlI/ZZQm
	 hVsQyVnRsciz2s+XNe3U5+IlbMQF1rrbD7UXny37Rx1QIVdLRzasTtK+Xao5LLOUhzvhF
	 g3KNCf8G6H1les1MM5eQMxO4HcZ43SF6IdI8IxF9mXONWhnaJVl2Ls1z6pCFW3WUxMsTe
	 yiawfKR/uci/NoXS3QstNDtTivUOrVzsGOXSkRut/xL964b9be1kxCyBNAX3F8yWzPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNIwNJ0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EE606A327
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNIwNJ0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F28F1F000C4;
	Sun, 15 Nov 2026 01:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707672;
	bh=g2mPCAiCLDND4z7jmAW8uIDcPP4RBQZp0wiTis4ym2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZNIwNJ0O5AdSmgyCiR5N5KVYQwIKbpFpU+VjMCAqxOBDTstobGpWK1D3eSd6QjTSC
	 cuZQzGFA8XBrQXqXLzzO6dD/jf7zt9xrcalz+b3QyMLbSA+G3ugS16+eMAgC81oFmZ
	 E4Dhxg8itu/Whq9IBKUJdeJRoiheDA8WXKJ/on9uOnMRUWI7hMzcrTiGuVxCiatZ0W
	 uNo2QIMBCQx46pPPw5uRNGNYkJSKQIKsl+bPNbiFP0P+a4c8ccfjcBeSLBJ/za92JB
	 Bu54HGRYfnf3ZSPIjKKnH0OTdofxY+fd3A3i49dGeD5CKCaLrNvi+OnC3emk0sbvfh
	 mtp1dajAvVqOw==
Message-ID: <sashiko-outbox-215177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-5-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:54:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member.  The test skips
> on 32-bit PIE builds, which load globals through the GOT.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D4

