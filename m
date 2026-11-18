Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039399;
	b=YKvm4RKIxyB+lE06asz5zbSqL+T4NLK+b6G5Z1knuHOy/SMtketWeU9uT9VN9h36DnVS
	 tqVqxEhU0t86dVi+GqzfQyjqFeh6zH9OLI7/jSj/n9efFSZoqb14xaWtog5/fMh2x1j47
	 jgwMBy8QfEMxWbJvciBv/rEctL7SKCh3QcSAAdYvjIAJpBN24peovg2Bl3JAFH0WG31pB
	 a5g4NWub5ZYkpzeIoyiJ92GLjyC54Ck88wWStYhJMyqUaH8a+YrH9nnnN+XDBZ3e3WmmS
	 lHniKUA3q1de+qmCiTdHsSIZYrOnmNOavSSa468CS9gyGoGQlFw/cUqf/XD6EgX2lYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039399;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VBxnEW4P3YIQREAxMQzmCSRhRXISSE/GdTM7m1BIz3o=;
	b=zW3A46jGl6c8LuEhibggMWhBN0NcnXHyTCsmuiEvTIbwni/mZomls4QjsMfnICvs+fxH
	 2sMsj4a7sg+6Hn8zw47z4niar46GLBrTLwdNDlHbXwAlWdmR8dSxT4jkBH4QVuKj/bATK
	 lV+GHtz3IiGUc//elXaYIPs9Z+1AJcvmPp17VHFBKaY20JO1w7OjlvwHat6BP34Gg1ybv
	 Z6bhInI/5Bq4A2IB+dBHF68qC1ecNCfLDdnaxSg7uLx+vNdxZCnrBcgERtozN4bD+V1yI
	 sxSi/BEUUpL0sEMbrvJwlK3kEvcUuWQAlGmiQY+Y8AXt8/1p8zLRWCEYDKpHssGXJSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkH8oYwx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE1606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkH8oYwx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7722C1F000C5;
	Wed, 18 Nov 2026 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039399;
	bh=VBxnEW4P3YIQREAxMQzmCSRhRXISSE/GdTM7m1BIz3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZkH8oYwx7ZcDSnGsnmCX4BbYMLqyq4a+rF4civPEbCA2nEL+eMDTg7lQNWdkkchXo
	 4FM3jFLRedG+yffYErFp82qttNq6N2VokO6PYldAmAZof1DeltJWDZtYrfd690nc8O
	 1PDCBA9rE2uxqKHIHASwl0gS/HsiNn2oFy/Ng4bPmSr/AXpGQlQwsiEBR1KncUtG7P
	 Tcf99FS4B1fe/5DoF/wq/4l4Mkierwn58Cl1Ds2imo/yHaHrP8asGOTHRH6wV/j2uH
	 k8hWIsxXQRNydD59CanfHchrqiiNG959SXajvQq2wBL7xtLXDQ9haeyNwE9pUl+Du3
	 JIiMYlbOJG6cg==
Message-ID: <sashiko-outbox-222070@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/13] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-9-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:03:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> With --code-with-type the instruction stats are printed from
> hists__find_annotations() before that event is annotated: the first
> event reports zeros and later events can report stale counts.  The data
> type total is only counted in --data-type mode, so --type-stat without
> it is incomplete too.
>=20
> Print the stats once after all events have been annotated, warning if
> --type-stat is used without --data-type.  Leave the TUI's alternate
> screen before printing, so the stats remain on the terminal.
>=20
> Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debug=
ging")
> Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debug=
ging")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D8

