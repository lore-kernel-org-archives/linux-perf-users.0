Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10951484226
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189101; cv=none; b=fL2dygebiSwQM/mLoeOZ3vyXqytOBlpVGbiYgqodsJVfyI2urSjnLc84djvI0DqsLZnumNKdEMd8lCP7I5YP4BBdOUoXKW3jahi6VOfwQOgBvt+Foy3jwRT2Tqk6q9bhwDBb5HWo+HmAXBbbCcLcMNWL37XJBV/9kh8fTw5a0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189101; c=relaxed/simple;
	bh=9MsgdLDAprKzfZta9Y7RKcCCHcSV19fzXQ600dFDvVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SPO+7S7vX2GxLjz+sH5AMf8/VsqGd2HgNX9BWPEq/JBH1PZq4gQFfwUxWjBcDSX6I2BHSP29RXP0dB5sqWhu1gA7Qo0JzB+ngJBSwjv9UX8IaCX7VpwOeBMsQnMGMvuD5igV4oqgeeBpPVtWnAxrmpf3r/bZLyz7GtbKA5YB8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGtzZxHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGtzZxHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378571F000FF;
	Wed, 23 Sep 2026 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189088;
	bh=EiSbsWwYOnDjmZEq+YlYJuF3oVxlbNOSIh09vy0hmYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGtzZxHuY5nbTt3TB3G9ewSm4CqKbUPuf2YWp9jP+/seFPFqqd4gNaQUuRQP+DZf5
	 bhb+v9kX0ojNO1cHPXHTcU6UDagGqz/8Gu0Jfcd0QXzRtPAKu55FF9u89JoYdLUdZv
	 cqORGYEQele810o8vzdJZfB9dcuNJjJfyckqRmoOYxZM+zIeKO82YJxXPSQN4DUCdL
	 Rg/GI5Hay388uW1msGZo0PSmmIWFC1Bjfb3tpNEBuCjvGTcqBe6UvuWPAhnaPMl2Gf
	 lnn6/zsZII36/CirMkxamvU5JkF9cAJgxf6Q1EI1fO9yk6DlFvkGxwUOuAjy7xJ5//
	 m3YJemgJybtWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 49/49] perf Documentation: Update for standalone
 Python scripts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-50-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-50-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:44:47 +0000
Message-Id: <20260923184448.378571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update perf-script documentation to reflect standalone Python script
> execution and the removal of embedded Python and Perl scripting:
> - Remove documentation for the removed -g and -s options and legacy
>   record/report script wrapper modes in perf-script.txt.
> - Remove references to perf-script-perl and delete obsolete
>   perf-script-perl.txt.
> - Rewrite perf-script-python.txt to document writing and running
>   standalone Python scripts using the perf module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D49

