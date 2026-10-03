Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8B2E888C;
	Sat,  3 Oct 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014843; cv=none; b=gmQAL7vfvz8Q/tVTBF8ruQhQO8QvGIZmjXjeaOVjLIFp4bzisTONbFbtGMI9lbNjt2F4p6HQ+vAXEC3XiIY67BK7jKwYiFtt5M7/K3SNNssqP3/DYEJKWcdpuPqAzbPycOflFQBsufqKAYisjQrU4sEgh2rogtV9kCzHEg3GhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014843; c=relaxed/simple;
	bh=7zte1ZmnmbXp5wCWs+zdLrEhyDT3EjhWQSrlTEMus0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lx4jsPg2r/SybRXSNDFcZMeN99ljfVpzAk9vN2gwGVnFu+J3tjvLnCNBy+yrf3b+sECY5vMn2R9Dz/A90knbEtOfuttkFGnxvMx81dzZhixelO5BOsiGpQ4anN5WC8ytdhxKlToWk7k2/ka3YwtzNiXx+hXdsP/6yo4N2+ce+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5mrHCgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5mrHCgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A21F0089B;
	Sat,  3 Oct 2026 08:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014842;
	bh=7zte1ZmnmbXp5wCWs+zdLrEhyDT3EjhWQSrlTEMus0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d5mrHCgKreNdVG8THI+QSyaaWs/XVJtLjJfYSubsAc+A8xkF5FmkagumcvQ6y7mji
	 IAGI+cuIwCq+dt+dgw1zoJ+fcf8BZSz7lWiZ7WkeovBtbJKCnss532qoLELkESgWSV
	 JyBZuaM5obOBI6MLUvXnvVsgjaGO7cNyWG+ZnVvIMW4rYgrp4MK+4b9wSTcvL8VGM1
	 9+Uw5w6U8GHHj7//JJk8Tl3NEAYGovK+txaGpyiZWHj5t04L/1YGeVcwKWhZyqIpJL
	 cgmGykrY/JBcjWEFEbBY1ME9O+dmyFtAJKHCU/YzQ9WvfDwSb3um2XqbkX5vG4UoVN
	 6brmIHfP/GUfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 08/11] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179101402530.22872.12892814568115529973.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101402530.22872.12892814568115529973.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:07:21 +0000
Message-Id: <20261003080722.282A21F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add set_wprobe and clear_wprobe event triggers to dynamically attach
> and detach hardware breakpoint address monitoring based on event field
> contents.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D8

