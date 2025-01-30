Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2F1E522;
	Thu, 30 Jan 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265734; cv=none; b=PtPcX88L0i9/l0aoipCZoG9Cn3sXmFx3M8+ca/XqyxCBHiXZTptwJ6WJwhT8JDg8gTlfDQvB2um3rKSm74Fs0XQ6v7i+spX5QE9deIaC0Tj/HaplbXZMPq6PLxAGVkxK2mz0Eq2Y9arjvEA1OP1KblbbpBb6u4xMuKZlpjbd7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265734; c=relaxed/simple;
	bh=CYCedbzrRqYfHYhbfyiSepZ11q6WvcBC2kdzpoZTMp8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NhsKvKs9YYhmKPl0HKA+JuBFc0CyiS08/5V+2SaKSw+351/oNAuw65QGseE6q2xtrJ7Qb1oqXX1MHzW1QaK2TfIaMA77gEJtYI1lKOwgyodE8GM+6GZpWeCWo+sZFedu4brHMYzoqmvIE8Am84Kw9qIvQAjoY1tWJitxwojdx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=MQFjTo+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aV2ONUtD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MQFjTo+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aV2ONUtD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 25FA11140168;
	Thu, 30 Jan 2025 14:35:30 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jan 2025 14:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738265729;
	 x=1738352129; bh=jN4r+MW+uM/Jb3r3K5HNEebpConefEg979mB2bUVrbE=; b=
	MQFjTo+8Ps2V2gv6+PC0hygA83af23HKMPdxhm6lRrXmQ5end/3jOJhHJqZK9vn8
	Uzmdt7SNGm/34g5JUYXRZvE4d0uvsxUnsS9H4zfxBQo98iV2tjrTqLCTAJ83clWl
	D+H1DvhLdToxaikJtC/6v2ddZ7/2w8RlBjF/RlXp5AKQ+WnpHw5d62BiGdThIohY
	KFR824JQpPMCy1Wypvn9+v0CcJuxz6QnLbeMg0mcl+jCueP0PlX3VFLs2yZzJXta
	WJpvtbE4/Oz4+ItqLWQqlO+jrm7u0Sd0sqiRR95WJEcQ2WK2uIbPD7Ie4ZCQqoyl
	Vl2aqS+SjfC0e4KC2no/Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738265729; x=1738352129; bh=j
	N4r+MW+uM/Jb3r3K5HNEebpConefEg979mB2bUVrbE=; b=aV2ONUtDYNcsqgzhf
	XtACOzgGadj28UQ8TGNQVMyfrkRSl575EK6SSp9TUmNOm/4S/eCJN5vdEN2V6DqX
	+vKiGTKxwjufcrHdo7Qu0o8OjIXgOcTRBp7xIuAxHb4KLxMslL+h/UYp/w172MiS
	dwJB5Y6ir99JFDFEJHir641JjV/C71t0+ihUQfYFMAXeVyUv7jHzV2ZMellSEWcD
	nE/yy5771eMnwrfC99mBQeGYN0ryIBYuo3vLF3Qas/uWmznpageBWDpUnGQCz0UF
	2X5WAwPdJG4AZY8iHNfKXimov99/ImVAkDciPCTyDfCs9o31yad/1e9AAcfhgxCI
	sYlZg==
X-ME-Sender: <xms:gdSbZ--9ce92BfMRsWvEPeBA1_dOM_2QzmzBCv8ZkhhEsRcmkorz2g>
    <xme:gdSbZ-u0XMYm5WbGLFqXluGR27RNnDbZuHRPmWoXe9T-9GO-SkKzUXI3hGGhgqpZX
    eoWdYXyHXUWbinr3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlvdefmdenucfjughrpefoggffhffvkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhephffghfevvedttdefheffgeel
    heekvdfhudefjeefuedvvdfgkeffveffheeiffeunecuffhomhgrihhnpehruhhsthdqlh
    grnhhgrdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtph
    htthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrvhhirdgsrghn
    ghhorhhirgesrghmugdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrg
    hrmhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqh
    hunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhofigrrhgutghhuhel
    heesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehirhhoghgvrhhssehgohhoghhlvgdrtghomhdprhgtphht
    thhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:gdSbZ0CCCEqf6ZsxjJd93BmePWHMMgsnZGmLnEsFPpSpQ1vSHDdUHA>
    <xmx:gdSbZ2dhiAJqtq-j7SxCHlmLivgfw9RsZJ2GZcQ1KhtIWT2VWIuvZg>
    <xmx:gdSbZzPHy_TOrDAdghkpK6AQaPYMVtlRyexUJrePKQDmQZVgi3OSyg>
    <xmx:gdSbZwk_pq09YIESxlbC-unKf79Q1lqrdPJJT5HLufkGHeWflUnXEg>
    <xmx:gdSbZ9WmD49f5M0biBR_bVn3VgZ2c19r2RMFuQDEtm5XsIVYCLC-CmE_>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0511918A006B; Thu, 30 Jan 2025 14:35:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jan 2025 11:35:08 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Ian Rogers" <irogers@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Kan Liang" <kan.liang@linux.intel.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "James Clark" <james.clark@linaro.org>,
 "Howard Chu" <howardchu95@gmail.com>,
 "Ravi Bangoria" <ravi.bangoria@amd.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org
Message-Id: <f500ef21-5c87-4c60-8453-d98ee637a60c@app.fastmail.com>
In-Reply-To: <20250129193037.573431-1-irogers@google.com>
References: <20250129193037.573431-1-irogers@google.com>
Subject: Re: [PATCH v1] perf symbol: Add rust v0 demangling support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ian,

Thanks so much for working on this!

Only did a quick skim. Seems like it'd be nice to reuse the official
demangler now that we know about it. Will be interesting to
see how that gets packaged for distros.

On Wed, Jan 29, 2025, at 11:30 AM, Ian Rogers wrote:
> Implement symbol demangling based on:
> https://doc.rust-lang.org/rustc/symbol-mangling/index.html
>
> Ensure recommended demangling examples match the expectations in the
> documentation.
>
> This was requested by Daniel Xu <dxu@dxuuu.xyz> in:
> https://lore.kernel.org/lkml/jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd6wvrsu@fcz6vrvepybb/
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This change is on top of the 18 patch v3 series:
> https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/
> ---
>  tools/perf/tests/Build                   |   1 +
>  tools/perf/tests/builtin-test.c          |   1 +
>  tools/perf/tests/demangle-rust-v0-test.c |  82 +++
>  tools/perf/tests/tests.h                 |   1 +
>  tools/perf/util/Build                    |   1 +
>  tools/perf/util/demangle-rust-v0.c       | 661 +++++++++++++++++++++++
>  tools/perf/util/demangle-rust-v0.h       |   7 +
>  tools/perf/util/symbol-elf.c             |  31 +-
>  8 files changed, 771 insertions(+), 14 deletions(-)
>  create mode 100644 tools/perf/tests/demangle-rust-v0-test.c
>  create mode 100644 tools/perf/util/demangle-rust-v0.c
>  create mode 100644 tools/perf/util/demangle-rust-v0.h
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 165ba84dc93f..d59d88abf0da 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -56,6 +56,7 @@ perf-test-y += genelf.o
>  perf-test-y += api-io.o
>  perf-test-y += demangle-java-test.o
>  perf-test-y += demangle-ocaml-test.o
> +perf-test-y += demangle-rust-v0-test.o
>  perf-test-y += pfm.o
>  perf-test-y += parse-metric.o
>  perf-test-y += expand-cgroup.o
> diff --git a/tools/perf/tests/builtin-test.c 
> b/tools/perf/tests/builtin-test.c
> index e77bf446e821..16937e7e313a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -126,6 +126,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__maps__merge_in,
>  	&suite__demangle_java,
>  	&suite__demangle_ocaml,
> +	&suite__demangle_rust,
>  	&suite__parse_metric,
>  	&suite__expand_cgroup_events,
>  	&suite__perf_time_to_tsc,
> diff --git a/tools/perf/tests/demangle-rust-v0-test.c 
> b/tools/perf/tests/demangle-rust-v0-test.c
> new file mode 100644
> index 000000000000..ab6613e02c94
> --- /dev/null
> +++ b/tools/perf/tests/demangle-rust-v0-test.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "tests.h"
> +#include "debug.h"
> +#include "demangle-rust-v0.h"
> +#include <linux/kernel.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +static int test__demangle_rust(struct test_suite *test __maybe_unused, 
> int subtest __maybe_unused)
> +{
> +	int ret = TEST_OK;
> +	char *buf = NULL;
> +	size_t i;
> +
> +	struct {
> +		const char *mangled, *demangled;
> +	} test_cases[] = {
> +		{ 
> "_RNvMsr_NtCs3ssYzQotkvD_3std4pathNtB5_7PathBuf3newCs15kBYyAo9fc_7mycrate",
> +		  "<std::path::PathBuf>::new" },
> +		{ "_RNvCs15kBYyAo9fc_7mycrate7example",
> +		  "mycrate::example" },
> +		{ "_RNvMs_Cs4Cv8Wi1oAIB_7mycrateNtB4_7Example3foo",
> +		  "<mycrate::Example>::foo" },
> +		{ "_RNvXCs15kBYyAo9fc_7mycrateNtB2_7ExampleNtB2_5Trait3foo",
> +		  "<mycrate::Example as mycrate::Trait>::foo" },
> +		{ "_RNvMCs7qp2U7fqm6G_7mycrateNtB2_7Example3foo",
> +		  "<mycrate::Example>::foo" },
> +		{ "_RNvMs_Cs7qp2U7fqm6G_7mycrateNtB4_7Example3bar",
> +		  "<mycrate::Example>::bar" },
> +		{ "_RNvYNtCs15kBYyAo9fc_7mycrate7ExampleNtB4_5Trait7exampleB4_",
> +		  "<mycrate::Example as mycrate::Trait>::example" },
> +		{ "_RNCNvCsgStHSCytQ6I_7mycrate4main0B3_",
> +		  "mycrate::main::{closure#0}" },
> +		{ "_RNCNvCsgStHSCytQ6I_7mycrate4mains_0B3_",
> +		  "mycrate::main::{closure#1}" },
> +		{ "_RINvCsgStHSCytQ6I_7mycrate7examplelKj1_EB2_",
> +		  "mycrate::example::<i32, 1>" },
> +		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleFG0_RL1_hRL0_tEuEB2_",
> +		  "mycrate::example::<(&'_2 u8, &'_1 u16) -> ()>",
> +		  /*
> +		   * TODO: the recommended demangling is:
> +		   * mycrate::example::<for<'a, 'b> fn(&'a u8, &'b u16)>
> +		   */
> +		},
> +		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleKy12345678_EB2_",
> +		  "mycrate::example::<305419896>" },
> +		{ 
> "_RNvNvMCsd9PVOYlP1UU_7mycrateINtB4_7ExamplepKpE3foo14EXAMPLE_STATIC",
> +		  "<mycrate::Example::<_, _>>::foo::EXAMPLE_STATIC"
> +		  /*
> +		   * TODO: the recommended demangling is (the :: is optional):
> +		   * <mycrate::Example<_, _>>::foo::EXAMPLE_STATIC
> +		   */
> +		},
> +		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleAtj8_EB2_",
> +		  "mycrate::example::<[u16; 8]>" },
> +		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleNtB2_7ExampleBw_EB2_",
> +		  "mycrate::example::<mycrate::Example, mycrate::Example>" },
> +		{ 
> "_RINvMsY_NtCseXNvpPnDBDp_3std4pathNtB6_4Path3neweECs7qp2U7fqm6G_7mycrate",
> +		  "<std::path::Path>::new::<str>" },
> +		{ "_RNvNvNvCs7qp2U7fqm6G_7mycrate7EXAMPLE7___getit5___KEY",
> +		  "mycrate::EXAMPLE::__getit::__KEY" },
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
> +		buf = rust_v0_demangle_sym(test_cases[i].mangled);
> +		if (!buf) {
> +			pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n", 
> test_cases[i].mangled,
> +				 test_cases[i].demangled);
> +			continue;
> +		}
> +		if (strcmp(buf, test_cases[i].demangled)) {
> +			pr_debug("FAILED: %s: %s != %s\n", test_cases[i].mangled,
> +				 buf, test_cases[i].demangled);
> +			ret = TEST_FAIL;
> +		}
> +		free(buf);
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_SUITE("Demangle Rust", demangle_rust);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 751c8489059a..e1e846c9da4e 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -157,6 +157,7 @@ DECLARE_SUITE(jit_write_elf);
>  DECLARE_SUITE(api_io);
>  DECLARE_SUITE(demangle_java);
>  DECLARE_SUITE(demangle_ocaml);
> +DECLARE_SUITE(demangle_rust);
>  DECLARE_SUITE(pfm);
>  DECLARE_SUITE(parse_metric);
>  DECLARE_SUITE(expand_cgroup_events);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 43408d2de4a2..d1c82d9ab4d7 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -240,6 +240,7 @@ perf-util-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
>  perf-util-y += demangle-ocaml.o
>  perf-util-y += demangle-java.o
>  perf-util-y += demangle-rust.o
> +perf-util-y += demangle-rust-v0.o
> 
>  ifdef CONFIG_JITDUMP
>  perf-util-$(CONFIG_LIBELF) += jitdump.o
> diff --git a/tools/perf/util/demangle-rust-v0.c 
> b/tools/perf/util/demangle-rust-v0.c
> new file mode 100644
> index 000000000000..8839cf2e63a0
> --- /dev/null
> +++ b/tools/perf/util/demangle-rust-v0.c
> @@ -0,0 +1,661 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "demangle-rust-v0.h"
> +#include "debug.h"
> +#include "strbuf.h"
> +
> +static bool show_crate_root_disambiguator = false;
> +
> +struct parse_state {
> +	/*
> +	 * The string itself after the initial "_R" from which all back
> +	 * references are decoded from.
> +	 */
> +	const char *str;
> +	/* Length of str. */
> +	size_t len;
> +	/* Offset within the string. */
> +	size_t offset;	
> +};
> +
> +static char parse_state__peek(const struct parse_state *state)
> +{
> +	pr_debug3("Peek '%c'\n", state->str[state->offset]);
> +	if (state->offset >= state->len)
> +		return '\0';
> +	return state->str[state->offset];
> +}
> +
> +static char parse_state__read(struct parse_state *state)
> +{
> +	pr_debug3("Read '%c'\n", state->str[state->offset]);
> +	if (state->offset >= state->len)
> +		return '\0';
> +	return state->str[state->offset++];
> +}
> +
> +static bool read_path(struct parse_state *state, struct strbuf* buf);
> +static bool read_type(struct parse_state *state, struct strbuf* buf);
> +
> +static bool read_decimal(struct parse_state *state, size_t *res)
> +{
> +	size_t orig_offset = state->offset;
> +
> +	*res = 0;
> +	while (true) {
> +		char ch = parse_state__read(state);
> +
> +		if (ch >= '0' && ch <= '9') {
> +			*res = (*res * 10) + ch - '0';
> +			continue;
> +		}
> +		state->offset--;
> +		break;
> +	}
> +
> +	pr_debug3("Read decimal: %zu\n", *res);
> +	/* Something was read if the offset changed. */
> +	return orig_offset != state->offset;
> +}
> +
> +static bool read_hexadecimal(struct parse_state *state, size_t *res)
> +{
> +	size_t orig_offset = state->offset;
> +
> +	*res = 0;
> +	while (true) {
> +		char ch = parse_state__read(state);
> +
> +		if (ch >= '0' && ch <= '9') {
> +			*res = (*res * 16) + ch - '0';
> +			continue;
> +		}
> +		if (ch >= 'a' && ch <= 'f') {
> +			*res = (*res * 16) + ch - 'a';
> +			continue;
> +		}
> +		if (ch >= 'A' && ch <= 'F') {
> +			*res = (*res * 16) + ch - 'A';
> +			continue;
> +		}
> +		state->offset--;
> +		break;
> +	}
> +
> +	pr_debug3("Read hexadecimal: %zu\n", *res);
> +	/* Something was read if the offset changed. */
> +	return orig_offset != state->offset;
> +}
> +
> +static bool read_base62(struct parse_state *state, size_t *res)
> +{
> +	char ch;
> +
> +	*res = 0;
> +	ch = parse_state__read(state);
> +	if (ch == '_') {
> +		pr_debug3("Read base62: %zu\n", *res);
> +		return true;
> +	}
> +	do {
> +		if (ch >= '0' && ch <= '9') {
> +			*res = (*res * 62) + ch - '0';
> +		} else if (ch >= 'a' && ch <= 'z') {
> +			*res = (*res * 62) + ch - 'a' + 10;
> +		} else 	if (ch >= 'A' && ch <= 'Z') {
> +			*res = (*res * 62) + ch - 'A' + 36;
> +		} else {
> +			pr_debug3("Unexpected base62 character '%c'\n", ch);
> +			return false;
> +		}
> +		ch = parse_state__read(state);
> +	} while (ch != '_');
> +
> +	/* The empty string encodes 0, 0_ encodes 1, etc. so adjust up. */
> +	(*res)++;
> +
> +	/* Something was read if the offset changed. */
> +	pr_debug3("Read base62: %zu\n", *res);
> +	return true;
> +}
> +
> +static bool read_optional_base62(struct parse_state *state, char 
> opt_char,
> +				 size_t *res, bool *has_res)
> +{
> +	*has_res = parse_state__peek(state) == opt_char;
> +	if (!*has_res)
> +		return true;
> +
> +	state->offset++;
> +	return read_base62(state, res);
> +}
> +
> +struct identifier {
> +	const char *bytes;
> +	size_t len;
> +	size_t disambiguator;
> +	bool has_disambiguator;
> +};
> +
> +static bool read_identifier(struct parse_state *state, struct 
> identifier *identifier)
> +{
> +	size_t num;
> +
> +	pr_debug3("Reading identifier\n");
> +	if (!read_optional_base62(state, 's', &identifier->disambiguator,
> +				  &identifier->has_disambiguator))
> +		return false;
> +	
> +	if (parse_state__peek(state) == 'u') {
> +		pr_warning("Punycode encoding ignored\n");
> +		state->offset++;
> +	}
> +	if (!read_decimal(state, &num)) {
> +		pr_debug3("Bad undisambiguated-identifier decimal-number\n");
> +		return false;
> +	}
> +	if (parse_state__peek(state) == '_') {
> +		/* Optional separator. */
> +		state->offset++;
> +	}
> +	identifier->bytes = &state->str[state->offset];
> +	identifier->len = num;
> +	if (state->offset + num > state->len) {
> +		pr_debug3("Identifier beyond end of input\n");
> +		return false;
> +	}
> +	state->offset += num;
> +	pr_debug3("Read identifer '%.*s'\n", (int)identifier->len, 
> identifier->bytes);
> +	return true;
> +}
> +
> +static bool read_crate_root(struct parse_state *state, struct strbuf* 
> buf)
> +{
> +	struct identifier identifier;
> +
> +	pr_debug3("Reading crate-root\n");
> +	if (!read_identifier(state, &identifier))
> +		return false;
> +
> +	if (strbuf_addf(buf, "%.*s", (int)identifier.len, identifier.bytes))
> +		return false;
> +	if (show_crate_root_disambiguator && identifier.has_disambiguator) {
> +		/* Ignore failure. */
> +		strbuf_addf(buf, "[%zu]", identifier.disambiguator);
> +	}
> +	return true;
> +}
> +
> +static bool read_impl_path(struct parse_state *state, struct strbuf* 
> buf)
> +{
> +	size_t disambiguator;
> +	bool has_disambiguator;
> +
> +	pr_debug3("Reading impl-path\n");
> +
> +	/* Ignore impl-path. */
> +	if (!read_optional_base62(state, 's', &disambiguator, 
> &has_disambiguator))
> +		return false;
> +	return read_path(state, buf);
> +}
> +
> +static bool read_tuple(struct parse_state *state, struct strbuf* buf)
> +{
> +	bool first = true;
> +
> +	pr_debug3("Reading tuple\n");
> +
> +	if (strbuf_addch(buf, '('))
> +		return false;
> +	while (parse_state__peek(state) != 'E') {
> +		if (!first && strbuf_addstr(buf, ", "))
> +			return false;
> +		first = false;
> +		if (!read_type(state, buf))
> +			return false;
> +	}
> +	state->offset++;
> +	return strbuf_addch(buf, ')') == 0;
> +}
> +
> +static bool read_backref(struct parse_state *state, size_t *new_offset)
> +{
> +	size_t backref_offset = state->offset - 1;
> +
> +	if (!read_base62(state, new_offset))
> +		return false;
> +
> +	if (*new_offset >= backref_offset) {
> +		pr_debug3("Backref offset (%zu) should be before current offset 
> (%zu)\n",
> +			  *new_offset, backref_offset);
> +		return false;
> +	}
> +	pr_debug3("Read backref to %zu\n", *new_offset);
> +	return true;
> +}
> +
> +static bool read_const(struct parse_state *state, struct strbuf* buf)
> +{
> +	size_t const_data;
> +	char ch = parse_state__read(state);
> +	bool negative = false, bracket;
> +
> +	pr_debug3("Reading const\n");
> +
> +	if (ch == 'p')
> +		return strbuf_addch(buf, '_') == 0;
> +
> +	if (ch == 'B') {
> +		size_t backref_off, saved_off;
> +
> +		if (!read_backref(state, &backref_off))
> +			return false;
> +		saved_off = state->offset;
> +		state->offset = backref_off;
> +		if (!read_const(state, buf))
> +			return false;
> +		state->offset = saved_off;
> +		return true;
> +	}
> +
> +	bracket = !(ch >= 'a' && ch <= 'z');
> +
> +	if (bracket) {
> +		state->offset--;
> +		if (!read_type(state, buf))
> +			return false;
> +	}
> +	if (parse_state__peek(state) == 'n') {
> +		state->offset++;
> +		negative = true;
> +	}
> +
> +	if (!read_hexadecimal(state, &const_data))
> +		return false;
> +
> +	if (parse_state__read(state) != '_') {
> +		pr_debug3("Missing const-data terminator\n");
> +		return false;
> +	}
> +	if (bracket && strbuf_addstr(buf, "::<"))
> +		return false;
> +	if (ch == 'b') {
> +		if (strbuf_addstr(buf, const_data ? "true" : "false"))
> +			return false;
> +	} else if (ch == 'c') {
> +		if (strbuf_addch(buf, const_data))
> +			return false;
> +	} else {
> +		if (negative) {
> +			if (strbuf_addch(buf, '-'))
> +				return false;
> +		}
> +		if (strbuf_addf(buf, "%zu", const_data))
> +			return false;
> +	}
> +	return !bracket || strbuf_addch(buf, '>') == 0;
> +}
> +
> +
> +static bool read_type(struct parse_state *state, struct strbuf* buf)
> +{
> +	char ch = parse_state__read(state);
> +
> +	pr_debug3("Reading type '%c'\n", ch);
> +
> +	switch (ch) {
> +		/* Basic types. */
> +	case 'a':
> +		return strbuf_addstr(buf, "i8") == 0;
> +	case 'b':
> +		return strbuf_addstr(buf, "bool") == 0;
> +	case 'c':
> +		return strbuf_addstr(buf, "char") == 0;
> +	case 'd':
> +		return strbuf_addstr(buf, "f64") == 0;
> +	case 'e':
> +		return strbuf_addstr(buf, "str") == 0;
> +	case 'f':
> +		return strbuf_addstr(buf, "f32") == 0;
> +	case 'h':
> +		return strbuf_addstr(buf, "u8") == 0;
> +	case 'i':
> +		return strbuf_addstr(buf, "isize") == 0;
> +	case 'j':
> +		return strbuf_addstr(buf, "usize") == 0;
> +	case 'l':
> +		return strbuf_addstr(buf, "i32") == 0;
> +	case 'm':
> +		return strbuf_addstr(buf, "u32") == 0;
> +	case 'n':
> +		return strbuf_addstr(buf, "i128") == 0;
> +	case 'o':
> +		return strbuf_addstr(buf, "u128") == 0;
> +	case 's':
> +		return strbuf_addstr(buf, "i16") == 0;
> +	case 't':
> +		return strbuf_addstr(buf, "u16") == 0;
> +	case 'u':
> +		return strbuf_addstr(buf, "()") == 0;
> +	case 'v':
> +		return strbuf_addstr(buf, "...") == 0;
> +	case 'x':
> +		return strbuf_addstr(buf, "i64") == 0;
> +	case 'y':
> +		return strbuf_addstr(buf, "u64") == 0;
> +	case 'z':
> +		return strbuf_addstr(buf, "!") == 0;
> +	case 'p':
> +		return strbuf_addstr(buf, "_") == 0;
> +		/* Array type. */
> +	case 'A':
> +		if (strbuf_addch(buf, '['))
> +			return false;
> +		if (!read_type(state, buf))
> +			return false;
> +		if (strbuf_addstr(buf, "; "))
> +			return false;
> +		if (!read_const(state, buf))
> +			return false;
> +		return strbuf_addch(buf, ']') == 0;
> +		/*  Slice. */
> +	case 'S':
> +		if (strbuf_addch(buf, '['))
> +			return false;
> +		if (!read_type(state, buf))
> +			return false;
> +		return strbuf_addch(buf, ']') == 0;
> +		/*  Tuple. */
> +	case 'T':
> +		return read_tuple(state, buf);
> +		/* Mutable reference/reference. */
> +	case 'Q':
> +	case 'R': {
> +		size_t lifetime;
> +		bool has_lifetime;
> +
> +		if (strbuf_addstr(buf, ch == 'Q' ? "&mut " : "&"))
> +			return false;
> +		if (!read_optional_base62(state, 'L', &lifetime, &has_lifetime))
> +			return false;
> +		if (has_lifetime) {
> +			/* TODO: proper lifetime naming. */
> +			if (strbuf_addf(buf, "'_%zu ", lifetime))
> +				return false;
> +		}
> +		return read_type(state, buf);
> +	}
> +		/* Constant raw pointer. */
> +	case 'P':
> +		if (strbuf_addstr(buf, "*const "))
> +			return false;
> +		return read_type(state, buf);
> +		/* Mutable raw pointer. */
> +	case 'O':
> +		if (strbuf_addstr(buf, "*mut "))
> +			return false;
> +		return read_type(state, buf);
> +		/* Function pointer. */
> +	case 'F': {
> +		size_t binder;
> +		bool has_binder;
> +
> +		if (!read_optional_base62(state, 'G', &binder, &has_binder))
> +			return false;
> +		if (parse_state__peek(state) == 'U') {
> +			/* Unsafe, ignored. */
> +			state->offset++;
> +		}
> +		if (parse_state__peek(state) == 'K') {
> +			/* ABI. */
> +			state->offset++;
> +			if (parse_state__peek(state) == 'C') {
> +				state->offset++;
> +			} else {
> +				struct identifier abi; /* Ignored. */
> +
> +				if (!read_identifier(state, &abi))
> +					return false;
> +			}
> +		}
> +		if (!read_tuple(state, buf))
> +			return false;
> +		if (strbuf_addstr(buf, " -> "))
> +			return false;
> +		return read_type(state, buf);		
> +	}
> +		/* Trait object. */
> +	case 'D':
> +		pr_err("Todo: rust trait demangling\n");
> +		return false;
> +		/* Path. */
> +	case 'C':
> +	case 'M':
> +	case 'X':
> +	case 'Y':
> +	case 'N':
> +	case 'I':
> +		state->offset--;
> +		return read_path(state, buf);
> +		/* Backref. */
> +	case 'B': {
> +		size_t backref_off, saved_off;
> +
> +		if (!read_backref(state, &backref_off))
> +			return false;
> +		saved_off = state->offset;
> +		state->offset = backref_off;
> +		if (!read_type(state, buf))
> +			return false;
> +		state->offset = saved_off;
> +		return true;
> +	}
> +	default:
> +		pr_err("Unexpected type character '%c'\n", ch);
> +		return false;
> +	}
> +}
> +
> +static bool read_inherent_impl(struct parse_state *state, struct 
> strbuf* buf)
> +{
> +	struct strbuf impl_path_buf = STRBUF_INIT; /* Ignored. */
> +
> +	pr_debug3("Reading inherent-impl\n");
> +
> +	if (!read_impl_path(state, &impl_path_buf))
> +		goto err_out;
> +	if (strbuf_addch(buf, '<'))
> +		goto err_out;
> +	if (!read_type(state, buf))
> +		goto err_out;
> +	return strbuf_addch(buf, '>') == 0;
> +err_out:
> +	strbuf_release(&impl_path_buf);
> +	return false;
> +}
> +
> +static bool read_trait_impl(struct parse_state *state __maybe_unused, 
> struct strbuf* buf __maybe_unused)
> +{
> +	struct strbuf impl_path_buf = STRBUF_INIT; /* Ignored. */
> +
> +	pr_debug3("Reading trait-impl\n");
> +
> +	if (!read_impl_path(state, &impl_path_buf))
> +		goto err_out;
> +	if (strbuf_addch(buf, '<'))
> +		goto err_out;
> +	if (!read_type(state, buf))
> +		goto err_out;
> +	if (strbuf_addstr(buf, " as "))
> +		goto err_out;
> +	if (!read_path(state, buf))
> +		goto err_out;
> +	return strbuf_addch(buf, '>') == 0;
> +err_out:
> +	strbuf_release(&impl_path_buf);
> +	return false;
> +}
> +
> +static bool read_trait_def(struct parse_state *state __maybe_unused, 
> struct strbuf* buf __maybe_unused)
> +{
> +	pr_debug3("Reading trait-def\n");
> +
> +	if (strbuf_addch(buf, '<'))
> +		return false;
> +	if (!read_type(state, buf))
> +		return false;
> +	if (strbuf_addstr(buf, " as "))
> +		return false;
> +	if (!read_path(state, buf))
> +		return false;
> +	return strbuf_addch(buf, '>') == 0;
> +}
> +
> +static bool read_nested_path(struct parse_state *state __maybe_unused, 
> struct strbuf* buf __maybe_unused)
> +{
> +	struct identifier identifier;
> +	size_t orig_buf_len = buf->len;
> +	char namespace = parse_state__read(state);
> +
> +	pr_debug3("Reading nested-path\n");
> +
> +	if (!read_path(state, buf))
> +		return false;
> +	if (strbuf_addstr(buf, "::"))
> +		return false;
> +	if (!read_identifier(state, &identifier))
> +		return false;
> +	if (strbuf_addf(buf, "%.*s", (int)identifier.len, identifier.bytes))
> +		return false;
> +	if (namespace == 'C' || namespace == 'S') {
> +		if (strbuf_addstr(buf, namespace == 'C' ? "{closure#" : "{shim#"))
> +			return false;
> +		if (identifier.has_disambiguator) {
> +			if (strbuf_addf(buf, "%zu}", identifier.disambiguator + 1))
> +				return false;
> +		} else {
> +			if (strbuf_addstr(buf, "0}"))
> +				return false;
> +		}
> +	} else if (namespace >= 'a' && namespace <= 'z') {
> +		/* Internal namespace character, don't show. */
> +	} else if (namespace >= 'A' && namespace <= 'Z') {
> +		if (strbuf_addch(buf, namespace))
> +			return false;
> +	} else {
> +		pr_debug3("Bad namespace '%c'\n", namespace);
> +		return false;
> +	}
> +
> +	pr_debug3("Read nested-path '%.*s'\n", (int)(buf->len - 
> orig_buf_len), &buf->buf[orig_buf_len]);
> +	return true;
> +}
> +
> +static bool read_generic_args(struct parse_state *state 
> __maybe_unused, struct strbuf* buf __maybe_unused)
> +{
> +	bool first = true;
> +	char ch;
> +
> +	pr_debug3("Reading generic-args\n");
> +
> +	if (!read_path(state, buf))
> +		return false;
> +	if (strbuf_addstr(buf, "::<"))
> +		return false;
> +
> +	ch = parse_state__read(state);
> +	while (ch != 'E') {
> +		if (!first && strbuf_addstr(buf, ", "))
> +			return false;
> +		first = false;
> +		if (ch == 'L') {
> +			size_t lifetime;
> +
> +			if (!read_base62(state, &lifetime))
> +				return false;
> +			/* TODO: proper lifetime naming. */
> +			if (strbuf_addf(buf, "'_%zu ", lifetime))
> +				return false;
> +		} else if (ch == 'K') {
> +			if (!read_const(state, buf))
> +				return false;
> +		} else {
> +			state->offset--;
> +			if (!read_type(state, buf))
> +				return false;
> +		}
> +		ch = parse_state__read(state);
> +	}
> +	return strbuf_addch(buf, '>') == 0;
> +}
> +
> +static bool read_path(struct parse_state *state, struct strbuf* buf)
> +{
> +	char ch = parse_state__read(state);
> +
> +	switch (ch) {
> +	case 'C':
> +		return read_crate_root(state, buf);
> +	case 'M':
> +		return read_inherent_impl(state, buf);
> +	case 'X':
> +		return read_trait_impl(state, buf);
> +	case 'Y':
> +		return read_trait_def(state, buf);
> +	case 'N':
> +		return read_nested_path(state, buf);
> +	case 'I':
> +		return read_generic_args(state, buf);
> +	case 'B': {
> +		size_t backref_off, saved_off;
> +
> +		if (!read_backref(state, &backref_off))
> +			return false;
> +		saved_off = state->offset;
> +		state->offset = backref_off;
> +		if (!read_path(state, buf))
> +			return false;
> +		state->offset = saved_off;
> +		return true;
> +	}
> +	default:
> +		pr_err("Unexpected path character '%c'\n", ch);
> +		return false;
> +	}
> +}
> +
> +char *rust_v0_bdemangle_sym(const char *str)

Typo? Extra `b`.

> +{
> +	struct parse_state state = {
> +		.str = str,
> +		.len = strlen(str),
> +		.offset = 0,
> +	};
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t encoding_version;
> +
> +	pr_debug3("Rust parsing of '%s'\n", str);
> +
> +	/* Check "_R" prefix is present. */
> +	if (parse_state__read(&state) != '_' || parse_state__read(&state) != 
> 'R')
> +		goto err_out;
> +
> +	/* Strip initial "_R" to make backrefs easier to decode. */
> +	state.str += 2;
> +	state.len -= 2;
> +	state.offset = 0;
> +
> +	/* Read optional encoding version. */
> +	if (read_decimal(&state, &encoding_version))
> +		pr_debug("Rust encoding version %zu\n", encoding_version);
> +
> +	if (!read_path(&state, &buf))
> +		goto err_out;
> +
> +	/* Ignore optional instantiating create. */
> +	/* Ignore optional vendor specific suffix. */
> +
> +	return strbuf_detach(&buf, NULL);
> +err_out:
> +	strbuf_release(&buf);
> +	return NULL;
> +}
> diff --git a/tools/perf/util/demangle-rust-v0.h 
> b/tools/perf/util/demangle-rust-v0.h
> new file mode 100644
> index 000000000000..d342c5319748
> --- /dev/null
> +++ b/tools/perf/util/demangle-rust-v0.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __PERF_DEMANGLE_RUST_V0
> +#define __PERF_DEMANGLE_RUST_V0 1
> +
> +char *rust_v0_demangle_sym(const char *str);
> +
> +#endif /* __PERF_DEMANGLE_RUST_V0 */
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 121db55b9709..41707425fc1a 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -16,6 +16,7 @@
>  #include "demangle-ocaml.h"
>  #include "demangle-java.h"
>  #include "demangle-rust.h"
> +#include "demangle-rust-v0.h"
>  #include "machine.h"
>  #include "vdso.h"
>  #include "debug.h"
> @@ -285,7 +286,7 @@ char *cxx_demangle_sym(const char *str 
> __maybe_unused, bool params __maybe_unuse
> 
>  static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
>  {
> -	char *demangled = NULL;
> +	char *demangled;
> 
>  	/*
>  	 * We need to figure out if the object was created from C++ sources
> @@ -293,23 +294,25 @@ static char *demangle_sym(struct dso *dso, int 
> kmodule, const char *elf_name)
>  	 * to it...
>  	 */
>  	if (!want_demangle(dso__kernel(dso) || kmodule))
> -		return demangled;
> +		return NULL;
> 
>  	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
> -	if (demangled == NULL) {
> -		demangled = ocaml_demangle_sym(elf_name);
> -		if (demangled == NULL) {
> -			demangled = java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
> -		}
> +	if (demangled) {
> +		/* Legacy rust demangling input is already C++ demangled. */
> +		if (rust_is_mangled(demangled))
> +			rust_demangle_sym(demangled);

In util/demangle-rust.c, I see:

     * INPUT:
     *     sym: symbol that has been through BFD-demangling

Perhaps double check that cxxabi is sufficient and update the comment?

> +		return demangled;
>  	}
> -	else if (rust_is_mangled(demangled))
> -		/*
> -		    * Input to Rust demangling is the BFD-demangled
> -		    * name which it Rust-demangles in place.
> -		    */
> -		rust_demangle_sym(demangled);
> 
> -	return demangled;
> +	demangled = rust_v0_demangle_sym(elf_name);
> +	if (demangled)
> +		return demangled;
> +
> +	demangled = ocaml_demangle_sym(elf_name);
> +	if (demangled)
> +		return demangled;
> +
> +	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
>  }
> 
>  struct rel_info {
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
