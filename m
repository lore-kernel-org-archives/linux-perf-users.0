Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8B248F51;
	Fri, 25 Jul 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469330; cv=none; b=SrlC8YlLuQKpZSVVjTFBzUAjxKCUZSrOe/zJvbtD/B4XgawdJvGHsHUIdWuB0+LRYOc91u0bUnsTqdSIjM8bmKkYdH6EcCOn14K6vIf4cs6x57N40yCwb3ieUHYXsYD5kWHXw3VphMDLgIBtk7mQpjRW9UDwQE0/BXEj7qwE4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469330; c=relaxed/simple;
	bh=RlknX0vzhROJhBJ1EeUOmu3hXegLxVyHI7T59Vp02nw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LLXbMXzntDc83R3Hl7PzwCeEygHpxfH/rQdvDew2ptcc7CUWZxlCyJU1BaSzi9GIoQqSAGDU24rPYkLLrIUsYHfD1L13xRHSxjPX1gxNvGnRqhj6ZLE6dOj+Uo9z/+v1IKsIgASb1a3/301ryyK50AZAu+rexaspCWNpbW8A8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRP4q7tm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRP4q7tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F26DC4CEEF;
	Fri, 25 Jul 2025 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469329;
	bh=RlknX0vzhROJhBJ1EeUOmu3hXegLxVyHI7T59Vp02nw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=FRP4q7tm1xPJeFdBL2wnwhO+fnUdjdzfRFEHmuiYjoTdxHrKJERSdMkAgIeKdn26H
	 oFqoQ/ebsKR7D9VZLzxrlO2NywY6fl39B5uPeu4NfIC9NtWoKTM9zTkz0WXv2AnKY0
	 oY7iVju4gNQ+hwyGajg51XI1K5vqj/8EY5AikJpfvkRfWCZgPWMLU5LeifJsl34Isu
	 PZboWBlOvw8ZGYLcgiOnyXNujgTh9m1CXFD3Pm6UyA2m08za5sGd/pndM96BwDaHrF
	 nm1XDK18hxgE9TtoF3uUIHUSmrO32DHkvKNzLA81i/ivSwsgbmByp9yY5knAcH4X5A
	 XwNBkhgbDgu3g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250722013449.146233-1-irogers@google.com>
References: <20250722013449.146233-1-irogers@google.com>
Subject: Re: [PATCH v1] perf pfm: Don't force loading of all PMUs
Message-Id: <175346932935.1444596.3621368930739538107.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 11:48:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 21 Jul 2025 18:34:49 -0700, Ian Rogers wrote:
> Force loading all PMUs adds significant cost because DRM and other
> PMUs are loaded, it should also not be required if the pmus__
> functions are used.
> 
> Tested by run perf test, in particular the pfm related tests. Also
> `perf list` is identical before and after.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


