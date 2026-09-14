Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF43FAE15;
	Mon, 14 Sep 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396527; cv=none; b=saMZk9vpsqkswWE5Pjludp4MBxGaIadYhnYi38kn7AIkf6wLy8vGBQ63ZO8DuTSa4oTyNiFPHLRZVFh0HnoCnJPgRNeVvA+EnO4Kyxt2cb6XSfdD51OO5rJUerAWdTzI3GM1azx7TWDhl11VFDLXXU7xNpdYSF9l216sFH3POvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396527; c=relaxed/simple;
	bh=fLIRiGCSKVss5ULKDOGWijGvZeXVKns8xNZTNhWK2Mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgh8LikhmcRe7EktjWzt/BrULjlq8t/zY+bKryP7gzxsCUOT97p3cb925SyWRfs+YXYvkWBYKYWMS3/fZD0b339onqEQ6B/Cs87KV+K9LdHhuMYm1RlG+MzS8/cNlAG1Ujf2WvF/cemNAzpNnZQm4WFuhB72S8sRF6VH1vC0/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1IgXtyW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1IgXtyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76E11F000FF;
	Mon, 14 Sep 2026 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396526;
	bh=fLIRiGCSKVss5ULKDOGWijGvZeXVKns8xNZTNhWK2Mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y1IgXtyWJOuhMyzPxac8I4wN4+siMLjiNuM45pjI2LJWfM1SMlAa3Kzrv0+0qCQuV
	 Iy1UrfSIc0icupigYCc6al7XrIYy0HNnKVUc8ExuxGPmZIyeWafxRx3UVPv9lcIwfn
	 qdgDCkwIDAlteP0aWZv3qRIjOsnDXyLryHc3smI7Or9F0Kx5HqIZFZ2hYSu20VOe3T
	 Itwg8g3rD920oNgvNHWW6asYgorW9utSnrwO6Ee6hGk3tpa27HYZWUN9Fc6fnZzEg9
	 jCarqbm01OCgICJKUZzclvvl3orLS1Cz4LgDlhxUkY1sRwkIfYZuQ9p3X5iTD2w1Qx
	 mwhzSzM5VgBlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 09/13] selftests: tracing: Add syntax testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178939028379.94750.17850398478754794031.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939028379.94750.17850398478754794031.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:35:25 +0000
Message-Id: <20260914143525.B76E11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
> of the watch probe events.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D9

