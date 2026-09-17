Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086837E5E7
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660949; cv=none; b=sApVf4j7rus0Y5Bo7GYREPyMGSTLYRlbYVG5djImE2iHfkgqFpCsKBbAvLNX4HGLZxpz62W8NLFi1neP/9Y+XQUPhN7LkvOKKLHFVl9qd+ZBr7ehJe/oreJ98tipG86zHdZ52kGFKdh3W0Y5oovRIUelcwFVr8RWHAm7LhRf7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660949; c=relaxed/simple;
	bh=pTEV0+CmFKKi1n9WQj2KCcWrfUJxB3LVYhXBbtNwoOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=in4j5QhEKzAmHp+mkAQ3NiY9NAITqKYHDY77ApDG27BYVujzxFD1dpL1xI4gnkL1GQ3FmrRBCmWV/fIbQETf25V1NXrKLFcVvoVK4VmTnYlLhBA1V+1RK33jXt111rSw3HrXUdZTDrkJw1AZwdjszsfBkY2Rh2RoIac4iE2oPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXhYz7hO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXhYz7hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8B01F00893;
	Thu, 17 Sep 2026 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660947;
	bh=oohrvJ8eTGSYnA11NB2kKvooy97IIZx6exmVeoU1Ak8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXhYz7hOL54a/oJtuCuByfomq35uWS6ueUYbmqmLdM4pewnKP2O6/1FS86H7tykCW
	 5YzMJf28TEEhbb56foD1Nvw8x8ZbHxItZmzC2I9Ty5YYnuxc6i60w7Ld/pUv0NpDBk
	 bndkp+fSt8kBwfHS8lBUrQECp0jY9Yf8kzNQFvi5ZPh8jkhpI4LlW6JhFiz4TEtf+y
	 Pd5KqKBwKuJEXKHIK3Ouo1BTT6neftd3g36ReTRn6pjv2dN8J218YhznufXaqei1ZR
	 AicCxv3JHaBWrVsmkiXuHz4N7Xk/orixvdWQASra6WXhCaoSYo3tVCG2gzKqwizMOB
	 /HOajBASggRFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-9-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:02:27 +0000
Message-Id: <20260917160227.8B8B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: the ui_progress updates
> are only shown by the TUI.  Add --progress, installing a stdio backend
> for ui_progress (ui/stdio/progress.c) that prints the phase title, the
> percentage and the current/total counts to stderr:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>   Merging related events... [ 61.0%] 309026 / 506686
>=20
> Phases can be nested, so the backend keeps track of the ones started so
> far to complete the right one on ui_progress__finish().  That requires
> init()/finish() to be paired, and the paths that returned early without
> the finish, in ordered-events.c and in the pipe and directory event
> processing, are fixed.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D8

