Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE777E9;
	Mon, 17 Mar 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244361; cv=none; b=ubpkjkUH5Yh9S/zSXwuTFH2uaKyFko/IGw2DSFpEa0NosX/aQ6mnpAxT13x4pxnn87fwKHzFaSkt55K//V5UufDIcC2ZKpVDK58qEwOV4UAVP8PrkVQ57iw2l1TZsVJw8d8TvW18QBhrwgE4oEPTzEUkB+mePp5K5oNjUz+mXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244361; c=relaxed/simple;
	bh=2LasYw7Dwe2vnzQ0dI1igRdg28abVwhLWwPZc20JEWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgvpwJDXtFp2ez+jmUhh9rvQCsAQtxtl2ratSu8VKte+VJcxzczZVeM/kPa4ZvaQGaukNmFRWwOeo19mL+W+dUTRlX3IzTFKJzuXYxt+dOKtu0/fVXHzVw1aBzJ0IDBgLCb+riVGqXIRlGFxzmXtiJXuQkDkmDlnuh6XBNLVu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuGgYKoG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuGgYKoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44A6C4CEE3;
	Mon, 17 Mar 2025 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244360;
	bh=2LasYw7Dwe2vnzQ0dI1igRdg28abVwhLWwPZc20JEWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CuGgYKoGPRQuJQMMmeNCUa9Sdk6VcRBsvB0EU6PWvWDGQ7TkzivtQ8dKV3Zme1MTM
	 6U4mncUP9QK8CJEXNqKoQInj6q0FOtbplnkk4EQWnIMVTn5cQxQSMc7sSq9IhWXvbe
	 QdO5bkHpFHJHcx4ou9WC+818Dmaf5ZvBLZsRu48BnInZpAtuqfXmYFtEG0GbcXrmDs
	 QjTOf56i02QjdRhzLa4p5fCSEfIlX0z/Djxt82T8A3bshESSHYzdD6nUiVQ2TLydgF
	 dd2Ne9Gv6C5F9yRaVqxPOMKCaTAkjIzgoPl2+tEmzMpLDAikuWu24HaN8g9Dq+V4It
	 /GtiC3hEFSXKg==
Date: Mon, 17 Mar 2025 17:45:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 0/6] perf python binding fixes
Message-ID: <Z9iKBXkxbYT5lmbf@x1>
References: <20250312203141.285263-1-acme@kernel.org>
 <CAP-5=fVp48KUB5sawBp-6t5DyzGqDfxtXReSSTQ-LDXFKMAvzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVp48KUB5sawBp-6t5DyzGqDfxtXReSSTQ-LDXFKMAvzQ@mail.gmail.com>

On Mon, Mar 17, 2025 at 10:41:28AM -0700, Ian Rogers wrote:
> On Wed, Mar 12, 2025 at 1:31 PM Arnaldo Carvalho de Melo
> > P.S.: In other news, the syscalltbl series from Ian built on all my
> > containers, I'm now trying to go over it patch by patch.

Doing some more tests on it, the -e case is fixed with Namhyung's fix
for re-reading the sc variable after the realloc.

> > Arnaldo Carvalho de Melo (6):
> >   perf python: Fixup description of sample.id event member
> >   perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc)
> >   perf python tracepoint.py: Change the COMM using setproctitle if available
> >   perf python: Decrement the refcount of just created event on failure
> >   perf python: Don't keep a raw_data pointer to consumed ring buffer space
> >   perf python: Check if there is space to copy all the event
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!

- Arnaldo
