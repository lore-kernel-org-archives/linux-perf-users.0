Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2905836997A
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182621; cv=none; b=iJ7Dg1ZsZApZw0Aq5W7s/M4OCvTcZxK42jhm3d9TTZFoJ0yLiwkRbSHOvDsHo2VXr8pA72W5ewYv1PU+vqdVTanGigQTyI0XMesTGwLdD2O4uyPwT/DkjC7nPyNg8gzjlDqFeGXQZBPNrPEoD66VNqWlNBUmQ6KM7iMC9AvT7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182621; c=relaxed/simple;
	bh=ddgX9t3KHnXUlc9CHIT07iFlZpuDB//aMdttQqMlDUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J20HIiQ4ZWJN4s85flC7VOrctzpC/pr6nFRKrMWDxVGKcwFjyJTgv7Q/PAqZ4flOXnHlC2Bhp0YA2/8JbtIrzt9jeMoi7+Pz4CVjoCKbKj+k5AgsQhVEXeVSZ/X0GrOTDkeTzkFab3PPyP/AoZ20JmF6ZrV+2LXBDFAZvv4Xrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv0ObBSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv0ObBSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53F91F000FF;
	Mon,  5 Oct 2026 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182619;
	bh=ddgX9t3KHnXUlc9CHIT07iFlZpuDB//aMdttQqMlDUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zv0ObBSsg3iLH1Lh4vOphdNoga0azwXyMJuClg2x1kJ9jqT0flc/xTruG29Ogfzij
	 MtUqg665j/p5EM8e8MvlYJXpCoHSGvTw6S8IZU8IaeBvQVThTjOCeP3ECtLmBWHzNH
	 ineupmQEZx4My8+F2jYScKM2n4k/9lOmhiWSKT3hn98PdgyJjyMFRC4+TTbWl4OZ3J
	 gCBzmS09LiQT95xYWmHjFIGhkYeboDa41vRJhlxcPoa9Vv8DgP26ACzSbHnzJL/VXh
	 S1eNWb+Da1cztcF5hO+oInHrnTAp0tIh1EnEjx85wNx8W0BOJ9pxRO0OZJ67Ty9afP
	 KE2S2ugliQI+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] perf tools: Try linked debug files for DSO debug
 info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005063411.114244-3-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:43:39 +0000
Message-Id: <20261005064339.B53F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The dso__find_dbginfo_type() should try DSO_BINARY_TYPE__DEBUGLINK so it
> can follow the .gnu_debuglink and find the debug information in the
> separate file.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005063411.1142=
44-1-namhyung@kernel.org?part=3D2

