Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623062;
	b=v4guNwwqSMVNfwga1hV9NKgEyVUYX23NqpgBxQMFtRc8+nD1JZEfrkLQn1OPwrjHF+E+
	 7phKNpE4FqYHZiLrjlNwNx+MHzRoPcqvgzsbvc2NqK4YgsQLXiZTQRM0BP5TySEyubOEZ
	 YSvKum9NnWAxrPrNIUqtR+qRq+C0xlK+U+WzbT4erj7MNtbRff3X5ygkRHtQKswEKIMF+
	 2DEucdKp8LKYkfNtkRgWjQ9Wi9Uu2uFjlXcNKRjoLN9i7AEueO9TpfiH3ScvcldPPCM1/
	 bfD5VmgwslGrOZqA/HcLBd6rP6v/KpoXpi5R/EpbLyykBkAJ+P4Lft5hqbCCv249btw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623062;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mvBeuDq6ydwuCff+FSxwXvZj/mKmek8UU6RKZi9jOPE=;
	b=bKZcm8vTWdcI8Jqyst7FcFKaVLoaVgVPXgOzlqJVxG6sSpSSRSe6Nf9CPQ+6t+PWE6SH
	 f+TarZ6niRDtmP7AGYOTd6j2Hal0uDrlTqOLubItXHVxpxtBCSuBJM3tUk9L3n2KB9Vfj
	 FO1l8hxSG92U0lnoaCVNGvCEh7hm7bFvuHUH0rAymPRe5cuX7rrdnxVNtYl+vZQZ+kOBe
	 iX/uJS9gGebf37VzmN5h0SaxqxzbpULS/ilHON3TAnVQOsbX0cXnPH80pmAy13O7z/vCK
	 k6wUxf5q8dOaDlp2uM4FqMjKSX7/HexatwGY7D3NmgTUf8cGbN2U8DToji7VQXmrAwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpElpczB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CB606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpElpczB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87541F000C1;
	Wed, 21 Oct 2026 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623062;
	bh=mvBeuDq6ydwuCff+FSxwXvZj/mKmek8UU6RKZi9jOPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpElpczBTOpujYWYzAcodLPcUefR1iqQK+G6iywDkKLIaTstb9usomB62MzoegI5U
	 2TVLuJNBUGMDjFdh0EzvovJMg95iZi6r26Fy5T7bkjVCKE4jjsNxr79n6UPWa0jRTT
	 YmzKsgJ6TeqFpbyiugD93ulziW3TQ1Or3MOaiFLkbdEaMIqRBhAtq63CKlLaDaeLl2
	 tjqCtXmfJYfrgEYRbnY8FP8v/+EIpaSOw+H2UKO2I4cc0RcIs4GmHwcK5vlCmJV2wp
	 C1NP/EiorENO5Au+bMNUlQUwdZaHPYIgpM4qDUVj6bMZ5QA302NOoGHsbUlGQslQrp
	 PpI042s7HCcew==
Message-ID: <sashiko-outbox-180745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/17] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-6-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:51:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D5

