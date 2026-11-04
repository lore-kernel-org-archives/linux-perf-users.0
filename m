Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755125;
	b=X6uCO63k86wombvjBDYCgmS9S/TXmOoNLrIC6PbMS2UiOEMGvuRQsE2R0zMxCqSl+E92
	 6Cw5ctR7pZ5+aMK4zcAritQEm4nYF4DWMprDdsbYdl+qrHv0fhrcYBrILpaPCggOQnG/j
	 12fFE0TF19M/hvvy+Jq0vVEFLijsi3EtbQbKVAQXVmmXD7rV0J3tI5vJRKENthI36veFL
	 K8Kyd1e8aN4yopRN7VeFXUxgLDtXoFXmn+NEm1HRgj+oKfbfbXaBs6dPQKfjDidEqv+dF
	 QavNWewRlCzkSfm9yhrE8iV6tq5YVZnh/yTGbUSWYuLNi7vt/VXvZvQDgwiAxaFh/ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tlQjZkxjJGycERPqY1j2o5M6cqzKTWdQQZp7mWcg7A4=;
	b=qt5X5WQXwJ6grNoQAVEBueBEcPoyNrDe4ZxM7f2JNuFKH5L6IfvP+T1PUdmBbu+HAOG/
	 JVoClOyftZksYqQbpwAnLLpnzazu59vxtBxP9o7N99dYhfbfpXPd5p0TRJgZkTWtjob6P
	 S6VIqr7elzY47OU3G4aF3ppxkJt8W3A4qAEsL6TXm7ekv7TKHUmHCE+v9slE44+icxOfG
	 SKLzcSMePWzj6SmxVTk22AKhqp91flj5VAhiawoTjHZdK7y/FhPucGElitqinniz1cy0v
	 MdUB00nUQrnVkir1qxtlcRZaH4/dZUjBYgKweiZQF5VmfSsFfVUkzXcNDlvC1oU7pwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWimwIqR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A71606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWimwIqR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FB01F000C1;
	Wed,  4 Nov 2026 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793755124;
	bh=tlQjZkxjJGycERPqY1j2o5M6cqzKTWdQQZp7mWcg7A4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SWimwIqRvR1gU6ONcP36s/d+UExQEhnZvWQXMBMjGFws782qp/5/ZVztAIDkANo/R
	 /XIZKV4vvJCXNd4zCvrV15YBouq0aiLc8mc1cDMQm5PmOhcwTKsQLpeqiXuDWIy+Mn
	 c6vwTK+48caB5Gr/NdL5j+SRIjU7lGJLK4dCO9omQs36r+VieIg1phntD/a0mXqrg7
	 +o66grlFUoB9Au6whLjCyrhs3U8ZaEDWfZ7kP5ZdPZ7ydBry5FizHsXz/VzE83JA70
	 37CI4ixytEBgYMF+tqRmV3qDY1B4sWyirQ+A9+7E3ePxQUfKMN3Ky+wkhduCS6/Gq2
	 DxXEKZrzZqDjA==
Message-ID: <sashiko-outbox-196352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/41] perf header: Pass e_machine to
 strcmp_cpuid_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-10-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:18:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The format of a CPUID depends on its architecture, but
> strcmp_cpuid_str() is only given the two CPUID strings and its
> architecture specific implementations assume the CPUIDs are for the
> architecture perf was built for.
>=20
> Pass the ELF machine of the CPUIDs' architecture to strcmp_cpuid_str()
> so that CPUIDs can be compared according to their architecture rather
> than the host's. The pmu-events tables pass their e_machine, comparisons
> with the host's CPUID pass EM_HOST and the arm64 CPUID matching test
> passes EM_AARCH64. The architecture specific implementations don't yet
> use the argument.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D9

