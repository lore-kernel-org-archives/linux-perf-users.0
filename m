Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94EA55D882
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172460; cv=none; b=PnyD79eWqQQBxM2OEBrZQPB+APF5VPF5RV9WQGB8dXHZVjkeZfvNGjmvFqpiGBgP+gtZeNXkQqz1EoW82J/Vz7zsRrqFKWGSCB+uOaWaWtiONL1OMNSKcjt2VpdJRg8dZ7uze4sQnNsRRsS0i6F1pV/qzOHWSUVuErB27T8gmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172460; c=relaxed/simple;
	bh=l49VOSyxBHoIYokdMkAUF3tNmlRxDtQGHGbW7hor4mA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ej8rXtrO+ERb2ELNyDC7o+cjUjRkXA5aIEc09DEv60Ky+1HIjyPk8VnrEijKw5yueiQlGRDPUEGOdbHAausctgt3HvuK/QlkcCckm4cgFvkt+INv1bIZgoGZSQlNoKXYKLuC3bg2i7UaIsKwOZadfJflFPz8B238t0UsGpO2sWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUGbVEHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUGbVEHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6241F000C4;
	Fri, 16 Oct 2026 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172459;
	bh=l49VOSyxBHoIYokdMkAUF3tNmlRxDtQGHGbW7hor4mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUGbVEHsXDT67bPqqs17w9khYt7kQTFKPQJPCJZjdrVSCCejTE4fxnYvW2sMh8/VT
	 EHXq2OAjH0hR06sSWVnlkJt5Hy3JNcf2pCqgVyTzduYX4HBa1XPDQeP4GK0VrLD/lQ
	 B2gV7Rgv8Pa4TIR6ItOtr9CN7rnWLdOO6uKgqiRnH90Qe2084kGdmWS6+PKtOBAsZr
	 McvQpMJQWxtW/TZ9+B6kP5VGzfuulpP1ld7hbqp/rCJZKl0hxfJwA6qugUDLLzEv1W
	 cFeefWyhfdO84aj6xgyIAEu87aZdafDfY0//v1QJ0zPVoXpqZ04qj5FcmdJKZRzp3o
	 +AZkpbcsTmvaw==
Message-ID: <sashiko-outbox-174733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/17] perf dso: Pass dso_data to close_data_fd() and
 dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-9-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:40:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D8

