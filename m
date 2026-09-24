Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370803911B5
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285740; cv=none; b=QsDG3qrQrlKY2hgy2z7svxF3KJ2BDPeviLXXssEBg1DbYXO9TAdSO5o51QC5ia1QfCiIlcTXR6653PsBxjq1D1w5yHzsfJjxD2tHCsykTP8fwFpV6/TAg58L0shnUWI3kaMZHnrOxcPV8cozJ3mwEai9eZ7+2D4pZJW0aAYfRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285740; c=relaxed/simple;
	bh=7cwQZO5AAEapOxWGqh1OF1bbt5DNNsSh+Yhb8vdt2Kk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XosXKty3MCeyc414thhBfEUvpFCZjueaWKGkYt4fl8naknVI9tBr1txPwRfYHY0wEgJQMUYdBW+alr0yfy9FIj7ivcVCG7EH1fSNDS1ZGiNsjOFoogq2TFoIopoLl9EM/cY6YD+mYe/tQ5VBZsRfm521+uxFceFDVVlFgNPLeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMu52EhU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMu52EhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732131F000FF;
	Thu, 24 Sep 2026 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285738;
	bh=7cwQZO5AAEapOxWGqh1OF1bbt5DNNsSh+Yhb8vdt2Kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMu52EhUVNdCVzzN/6ZV8R59WxHp4ummzQiFc9XIWR/32Y+boWQLL1AVMvMwyp2XY
	 c1QVxX5+Y7GHOpQX6llXeVd+D0LbkETjEZaKZAnVMUetmTIwyASMiHr3HSvMSYIArH
	 iRDyCa4WYtqrZ0HP9T9qsbO3k8JCTUGZm3OmNDe+ITDp0h6h34wgZDiBPQd/vyKnam
	 MSuTXemu+gG2yWWXJejnI5ZtEcfSKDOalo0d1e3Qd6q/eiW9BGUTdzrTNv0/Z6PfDH
	 OXU0xMPsbisLnUDP0R0vW+w/Jm+UTK+Jrve6GA9tgVyJgC/VgD6xUcuvad/XvZlJnO
	 s7txa2avBvBeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] perf annotate-data: Bound the member nesting
 recursion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924212809.1733663-5-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 21:35:38 +0000
Message-Id: <20260924213538.732131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Members are added recursively, and a broken DIE can make a member's
> type point back at one of its own ancestors, recursing until the stack
> is gone; nothing usable comes out of nesting members 32 deep anyway, so
> stop there, marking the member as truncated and giving up on member
> types that don't resolve.
>=20
> The check is where the children of an aggregate would be expanded, so
> only struct/union members are marked as truncated.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924212809.1733=
663-1-acme@kernel.org?part=3D4

