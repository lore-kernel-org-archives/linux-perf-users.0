Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A461A9F9F;
	Wed,  7 Jan 2026 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771372; cv=none; b=jKXQBQwqSJXD9LJorPNriTtol5GBtyq7rij12agxMvpk0W4weiiFNiKeNHD9Wsm9VNQZwfXJ/UmR6a4Ip01bmirkm811UGKvdMwgwdZk5QuU4bnheCxVo38c+iLl98LE2e4tnec0Sp/MiQCK/AGb12nbtFHOZckh0ZnC1S4IdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771372; c=relaxed/simple;
	bh=lywQyW9RcBZcEA8jn/KUvgRQT6Pn+Eo/QzONzR+3MVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWoQ+2bI4DYdyFkBUTYzMECaDTS8XL4UxwL5ycB9nmCfpBuqs/rtkwbeCwPGS5MoVT6XMhNm0Hs6zgh7GG4KfIjE9cWgndSIhfUVTaP9jyKPyeA3vyrqn1y5FXw0PSvLb9b7iEVhiItMEdYg/PzcyHxv5sypfdPlM5xYqlZ2Jwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Caylq5on; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Caylq5on"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D395C19421;
	Wed,  7 Jan 2026 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767771372;
	bh=lywQyW9RcBZcEA8jn/KUvgRQT6Pn+Eo/QzONzR+3MVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Caylq5onZF81xC8fAqWoE3USDfmE4nW645q8rW1KGZA20gMDy0nFgYSwAnWajq7Qp
	 zSAt46TNxnmB89bAyyOVO0pxgypTZJN+1qvxFmgMd0WkCIZXlTm7xPs2WVX1WPUI4C
	 CwsqSC5c3Cu942G0qoZ+9xwewHOt7VNAeR+JqN1Ezly98bgL4wRkRnKJIIJ9Fgwx+6
	 IAjK4IJOt8xIel1lMKbg2IDFkAhoeXUcD4WOItey3uFKQSkio0R1Be+SWaQ5E3KhQK
	 nlwRxTH14fuqU3NfPCJSLrLnhTnS8VvvYSUvPAYpKJb+7VRGt59tAz9iK/Ewafpidy
	 OFD8R/iUr8zKg==
Date: Tue, 6 Jan 2026 23:36:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Nicolas Schier <n.schier@avm.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>, Philipp Hahn <p.hahn@avm.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v2] perf test perftool_testsuite: Add missing shellcheck
 source directive
Message-ID: <aV4M6aJ5oK_xlZ7_@google.com>
References: <20260106-perf-add-shellcheck-sc1090-annotation-v2-1-bd52dc47369e@avm.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106-perf-add-shellcheck-sc1090-annotation-v2-1-bd52dc47369e@avm.de>

Hello,

On Tue, Jan 06, 2026 at 01:59:25PM +0100, Nicolas Schier wrote:
> Add shellcheck source directive to prevent old versions of shellcheck to
> issue warning SC1090 for perf shell scripts, e.g.:
> 
>     In tests/shell/base_probe/test_line_semantics.sh line 20:
>     . "$DIR_PATH/../common/init.sh"
>       ^---------------------------^ SC1090: Can't follow non-constant source. Use a directive to specify location.
> 
> shellcheck versions since 0.7.2 handle such dynamic source includes in a
> more friendly manner [1]; older versions show the warning and thus
> break the perf build unless NO_SHELLCHECK is set to '1'.
> 
> Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
> Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
> Signed-off-by: Nicolas Schier <n.schier@avm.de>
> ---
> Changes in v2:
>   * Extend commit message and mention affected shellcheck versions
>     (< 0.7.2)
>   * Link to v1: https://lore.kernel.org/r/20251229-perf-add-shellcheck-sc1090-annotation-v1-1-083821aeefa6@avm.de
> ---
> Another way w/o new shellcheck directives would be to update the minimum
> shellcheck version in tools/perf/Makefile.perf to 0.7.2.  I'll send
> that as an alternative patch.

Thanks for doing this, I think that's much simpler than this.

> 
> Newer versions of shellcheck are available since e.g.
> Debian bookworm 12 (released: 2023/06), Ubuntu jammy 22.04 (released:
> 2022/04), Fedora 37 (released: 2022/11)
> ---
>  tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh | 1 +
>  tools/perf/tests/shell/base_probe/test_adding_kernel.sh      | 1 +
>  tools/perf/tests/shell/base_probe/test_basic.sh              | 1 +
>  tools/perf/tests/shell/base_probe/test_invalid_options.sh    | 1 +
>  tools/perf/tests/shell/base_probe/test_line_semantics.sh     | 1 +
>  tools/perf/tests/shell/base_report/setup.sh                  | 1 +
>  tools/perf/tests/shell/base_report/test_basic.sh             | 1 +
>  7 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> index f74aab5c5d7f85b04f68090515acdfa49b6bccf3..06fca7d2cbb407eaea57df79bef11e26b49f9841 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> @@ -17,6 +17,7 @@ DIR_PATH="$(dirname $0)"
>  TEST_RESULT=0
>  
>  # include working environment
> +# shellcheck source=tests/shell/common/init.sh
>  . "$DIR_PATH/../common/init.sh"

I'm not sure how shellcheck handles the source directory, but I think we
used to assume it's the directory where the current script is on.

Something like:

  # shellcheck source=../common/init.sh

But as I said, it'd be better to increase the minimal shellcheck version
if it can handle that automatically.

Thanks,
Namhyung

>  
>  # skip if not supported
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> index 555a825d55f24543e3b6d105660c2cb505080e04..b6f9c4a697921b232a4795afcba10882e6101ce9 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -17,6 +17,7 @@ DIR_PATH="$(dirname $0)"
>  TEST_RESULT=0
>  
>  # include working environment
> +# shellcheck source=tests/shell/common/init.sh
>  . "$DIR_PATH/../common/init.sh"
>  
>  # shellcheck source=lib/probe_vfs_getname.sh
> diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
> index 162838ddc974d04d806b22366866f8201802f969..f2db48cb9b8feffc6de1f3ea50a1dc99cb44f377 100755
> --- a/tools/perf/tests/shell/base_probe/test_basic.sh
> +++ b/tools/perf/tests/shell/base_probe/test_basic.sh
> @@ -16,6 +16,7 @@ DIR_PATH="$(dirname $0)"
>  TEST_RESULT=0
>  
>  # include working environment
> +# shellcheck source=tests/shell/common/init.sh
>  . "$DIR_PATH/../common/init.sh"
>  
>  if ! check_kprobes_available; then
> diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> index 44a3ae014bfa2ffa831b86796b2e5187311d7303..3ae9afe6288b04d90777ebf5cdc64342f270eb75 100755
> --- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> +++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> @@ -16,6 +16,7 @@ DIR_PATH="$(dirname $0)"
>  TEST_RESULT=0
>  
>  # include working environment
> +# shellcheck source=tests/shell/common/init.sh
>  . "$DIR_PATH/../common/init.sh"
>  
>  if ! check_kprobes_available; then
> diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> index 576442d87a44400a65edce95b23070ce56f32993..4a1189c6cb0cbc269672c47efa617d20b0b4e795 100755
> --- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> +++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> @@ -17,6 +17,7 @@ DIR_PATH="$(dirname $0)"
>  TEST_RESULT=0
>  
>  # include working environment
> +# shellcheck source=tests/shell/common/init.sh
>  . "$DIR_PATH/../common/init.sh"
>  
>  if ! check_kprobes_available; then
> diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tests/shell/base_report/setup.sh
> index bb49b0fabb11499d4fb20d3c8c325d7f081cf18b..bc1dd8c128a6a57fd0a8ba94e51f0b11453a31de 100755
> --- a/tools/perf/tests/shell/base_report/setup.sh
> +++ b/tools/perf/tests/shell/base_report/setup.sh
> @@ -15,6 +15,7 @@
>  DIR_PATH="$(dirname $0)"
>  
>  # include working environment
> +# shellcheck source=tests/shell/common/init.sh
>  . "$DIR_PATH/../common/init.sh"
>  
>  TEST_RESULT=0
> diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
> index 0dfe7e5fd1ca609535fa70b03c8301373ec3fe6f..4cbc7c67f7bb9ccd79f950b731c604a426c5bfd0 100755
> --- a/tools/perf/tests/shell/base_report/test_basic.sh
> +++ b/tools/perf/tests/shell/base_report/test_basic.sh
> @@ -16,6 +16,7 @@ DIR_PATH="$(dirname $0)"
>  TEST_RESULT=0
>  
>  # include working environment
> +# shellcheck source=tests/shell/common/init.sh
>  . "$DIR_PATH/../common/init.sh"
>  
>  
> 
> ---
> base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
> change-id: 20251229-perf-add-shellcheck-sc1090-annotation-fec8beb43c1e
> 
> Best regards,
> -- 
> Nicolas Schier
> 
