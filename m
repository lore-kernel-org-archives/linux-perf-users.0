Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2ED44C67E;
	Thu,  6 Aug 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033064; cv=none; b=PqAUsPJbgTjsbTNvypoiWfTzk5/5VoYK3GrwQ0BmSjary4kJlmKz4WwPkLW/f1foPh1A3/aCcMc2MLJE4/cDZEwJ0owVCaubqEQW0mGTHlnTdH2+gAwVe2YZn1fhtpJ4Z3MARI5qXe8Xa7tW7y9ffQ1O3MnGs1kB0uPKyiyuPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033064; c=relaxed/simple;
	bh=SXWrNQeuXJffp9WekLzAXgbf2wIknzyiUUtJdUewTgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qewZwOrjgwxK/Ed2R68ZmiZNiP8dVuVd1F/UVzlttPi0gylEDmKKX+VFq0saUJrL7x8fn0ANh0e4bsrwMCgZLtT6JK4eZlHH6LlUcp0puN/m8iToiJnyfXsdRMe/RnsK8OglMktbyYkGQhEpQ7GCEWGZdXkEUQExCARtfXkWLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDa/wUig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDa/wUig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EABB1F000E9;
	Thu,  6 Aug 2026 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033060;
	bh=k87RrY0vJTJYxtNr9jQLel+a/0syg8JjUE7Udqn0NFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dDa/wUiguIrxlrKiNf4fCw+jBjliEzKCzCZKh5rEnMY1we6aUe8PzFxqDtslDmArB
	 RM/t/RKj2ym1ab3KVIgCCx4aPHg6CNZdq9oa8oxYCrut1t9YivWCUnPfJ3Qe0lIdgg
	 a3iFrqJPuOUT/rgxU4wrDQF+z4TYFBHUYPaaKyEx6v6NiW4sDHt/rJsXm8TL1nKV5T
	 Lu/tgLH1zRSOsBnz6QqxgnrxQS6/dqQthmuG6jRZnpLjwErILkU9SWH0JUslt120XH
	 vX4ulAH8U0eZ5/G+Z6DEF0RZKtelUd5vXR9u88TQs6BVl/kVdBX4WLZI3LXsPkrJz4
	 Om2oWQns2SoVQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260805151043.237233-1-acme@kernel.org>
References: <20260805151043.237233-1-acme@kernel.org>
Subject: Re: [PATCHES v8 0/2] perf c2c hardening
Message-Id: <178603306054.1984988.376851294249543813.b4-ty@kernel.org>
Date: Thu, 06 Aug 2026 09:17:40 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 05 Aug 2026 12:10:41 -0300, Arnaldo Carvalho de Melo wrote:
> 	Please consider merging,
> 
> Two hardening fixes for perf c2c found by the sashiko-bot AI reviewer.
> 
> Patch 1 fixes error masking, OOM, and unchecked caller errors in
> hpp_list__parse(): the strdup() return values are now checked, PARSE_LIST
> was turned into a function that bails out on any error returned by the
> parsing callbacks (including -ENOMEM), and the two callers bailing out
> with the newly propagated errors, setup_sort_list() and
> setup_output_list(), now break out of their token loops and propagate the
> error instead of silently overwriting it on the next iteration.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


