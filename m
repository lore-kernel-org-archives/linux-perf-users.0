Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AE3168E6
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898611; cv=none; b=dRv8yTc+nl4uVEJHmvqZqZiAI7gpjk2rk5XhksDCQ9UImgoNmpGRUuge3skANK80/9bqeWhRLe2eQddN4nDBvivNxZi3GW0y5/1vn9edlJIAk5SRuof1v2Vs+QPhFJRDeDLL/u3rVOn1dnk2X3Y6UKf5GWV+oXOrlfWOVmd+76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898611; c=relaxed/simple;
	bh=X255389d8UTTh7AnlGdhEefszJFN7nnFEJgqrOBgGlY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TqbNNJK8Pksv8BIqaeSGV5OgUjDVYokUB64gRqCBj9+vv+WxQ/rGc8LA9P2j2ik99tRfedhv0Icp7jNKTk5JP9XZWpT+qPlYXT8zUzEcDtEZEQfZl9afNOFuLfnvRYzHZ/Dvx9tivwCtyItf9xwZPxXvZypuayG3+NaH+UgQOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxur/jVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxur/jVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522771F00898;
	Tue, 13 Oct 2026 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898610;
	bh=X255389d8UTTh7AnlGdhEefszJFN7nnFEJgqrOBgGlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kxur/jVrPQOiq+WrumpVuK3UYmdDOrtDGTlUHIkSy5/fC0/wYRN1ohPDC00QO8p0D
	 j0i/+JUi1GyBgud1zoPx8mAXiJAUQNgiKgYkON7V2KmpPPLjQ1xgoZZ7j4lJLyy/VT
	 s0eH1yc5Dnr6BvcfPRjYNiICuJZhbkCpD3d67g+iVDh8gma1UcBM8hfXC4ry+pBbRA
	 8YlnbR46N+UuHAPLbyhR0waDocoB/on4psoD2ztIHlY6ygvZm0w1PEA8vv+jwXXueP
	 bsLqFZ0aAr/sBo8+tE26dM2xNiPlpiiRSxaAHcrLMecGGePSPEKCUxTGq24MBfmnbr
	 SajvSFl/AbvKQ==
Message-ID: <sashiko-outbox-169828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/15] perf annotate-arm64: Track return type after
 call instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f8c9b6af291a7e6f13dd659fb4b08cf171aa0331.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <f8c9b6af291a7e6f13dd659fb4b08cf171aa0331.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:36:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable data type profiling to track function return values in arm64
> annotations by looking up the DWARF return type of called functions.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D4

