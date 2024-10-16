Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70287212627;
	Wed, 16 Oct 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098763; cv=none; b=G7+mL3mGiFnnvHLAyQiU+pTHGuiR2n6wu9Tm6K8wAEd1hySjkXhdnDgTFkKrimmHQTTI382LOSDRUMM7Zx2Ljx+tmfQmKv5oLw6ApvNeVAyqckP8Bqyi7lj8xD2dDfp+W9BrGRCglwOWVeWUOH43BtGZFxQJj8Tvn6rPr1KWF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098763; c=relaxed/simple;
	bh=JsUthygbYceZEJx3q7rytEwLvBuAMfRzz12VG6hZAww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DrHWyfZb4fv5kfEOQYg4uLr/6lzse+m2mc9EaUlsMq4f7oGfZ2OU1hc+E5IFKxUrOPacpOmqpxwws7cTcZbFz7pI7nj1kH0TTo9vqEnP/TchjSBoRWTYV3quoyMZUgGynUhnUgdhj0fwJwxTkZSjzZR6K5xS1/cpaBV8+HYdvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7C/l4ES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7C/l4ES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE93C4CED2;
	Wed, 16 Oct 2024 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729098763;
	bh=JsUthygbYceZEJx3q7rytEwLvBuAMfRzz12VG6hZAww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g7C/l4ESdupMl7BNZRYjl87S9vqDDZrbsIJ/XvlRHNEP3sV9NbP+bSWQmWMBfru8I
	 7EIS6u/8QyNcBLCuuCTum+raP4JdaRxHVwdcg1fMKzx3PSmUj7OmyYAC4ZZtnaKNFo
	 38vE2+zx12QxD/0XlGSWLqsDuXPWmn2eRnuRBwlddlhsJRaBMjVZxLnKbwuwp5jfLL
	 7yqsYDYbaSXOVuGb1/9fjU38O+aRcFH/G/KJZOyfgL2QygJFqmxtq4KXTHnBsPTfew
	 Ptfucb5nhMEA4skkRBJVUaCkew/HvsLVbztMjb4YKp6xWs77Z4ySYsXYZePfI/RT8y
	 jAX7VjbGu/V6w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Ben Gainey <ben.gainey@arm.com>
In-Reply-To: <20241009062250.730192-1-namhyung@kernel.org>
References: <20241009062250.730192-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf evsel: Fix missing inherit + sample read check
Message-Id: <172909876265.288721.7311517520691951723.b4-ty@kernel.org>
Date: Wed, 16 Oct 2024 10:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 08 Oct 2024 23:22:50 -0700, Namhyung Kim wrote:

> It should not clear the inherit bit simply because the kernel doesn't
> support the sample read with it.  IOW the inherit bit should be kept
> when the sample read is not requested for the event.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

