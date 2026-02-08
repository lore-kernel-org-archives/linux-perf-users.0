Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B7254841;
	Sun,  8 Feb 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770560852; cv=none; b=XV9i2xw0JJIQ+3glCkkQk2mKeZf/4FRTKkYGyD0Y1KXvTdfETOgdpdcCd6sLkWMo0z5NQCuWiXTT0qeEIDxDNCisezMkhGxss5tP/iUm2oET2v9RFVf7Qk4g2EvA6GD8THa00bU7kCzFUz7+RK88TeLJGaCnd1GFPTUQM+IsY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770560852; c=relaxed/simple;
	bh=Zofiajm9pr3b2r4ArAJuqzD7qdMxplrVuvURpeU/TYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upAjiijYmnv+y5pB5dydlEuGTJjOLKbUHnT2R6lkED5/DeHlNq+sWT+HUqyjvjDXhAX8TP31gFUNg8WlRp4uHlodf6E8e/3/EffkcI5jANOv9rnIY7tO4CXYMdekLt4Ik168gRw2AjKsHX6/S1ZSB5h2rTQHtAg1jKANZRYt9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOWX2HJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOWX2HJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB9EC4CEF7;
	Sun,  8 Feb 2026 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770560851;
	bh=Zofiajm9pr3b2r4ArAJuqzD7qdMxplrVuvURpeU/TYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOWX2HJwZB86qWhO7GGw+dkocJwfYHG0ihx2QtTpAvsLcyHzyCvQF+B8tcjRG9zo0
	 A5XIInhGKVDDQoa3CiV2lY0Y2+lTPeyblUDVaHRlde5GHOfY/4fpfqNKMeu32PATS/
	 J2I41rIz5Vrdj3bH99JeEjqkYZZhJ4BsN+n6fzWNpyUKSzkm+xE2AaVtMwxfIoATiA
	 UPooCewfIluCHGU4gO9XIkulD6Rs8wQlZ65Zv8zKvjaCwRkjzJdEnEIOgLU3MSVqQu
	 6nh05A1P0ZNYwHZGbEWKVtyWN4dkXiQp/5w8HB1t+yzF3SPydI24UT4wPSe9/y58Cu
	 B9g0K1cJSwJxQ==
Date: Sun, 8 Feb 2026 11:27:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test record.sh: Fix shellcheck warning
Message-ID: <aYidT9oKKB9LVvw6@x1>
References: <20260207230452.1886143-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207230452.1886143-1-irogers@google.com>

On Sat, Feb 07, 2026 at 03:04:52PM -0800, Ian Rogers wrote:
> Add quotes to avoid the following warning:
> ```
> In tests/shell/record.sh line 264:
>  [ $(uname -m) = "s390x" ] && {
>    ^---------^ SC2046 (warning): Quote this to prevent word splitting.
> 
> For more information:
>  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
> ```
> 
> Fixes: c73a56ed3c97 ("perf test: Fix test case Leader sampling on s390")

Thanks, applied to perf-tools-next,

- Arnaldo
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 46b96d565680..7cb81cf3444a 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -261,7 +261,7 @@ test_uid() {
>  test_leader_sampling() {
>    echo "Basic leader sampling test"
>    events="{cycles,cycles}:Su"
> -  [ $(uname -m) = "s390x" ] && {
> +  [ "$(uname -m)" = "s390x" ] && {
>      [ ! -d /sys/devices/cpum_sf ] && {
>        echo "No CPUMF [Skipped record]"
>        return
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
