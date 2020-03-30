From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v7 4/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Mon, 30 Mar 2020 21:35:36 +0200
Message-ID: <20200330193536.GC2490231@krava>
References: <20200327102528.4267-1-kjain@linux.ibm.com>
 <20200327102528.4267-5-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200327102528.4267-5-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 27, 2020 at 03:55:26PM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index ea10fc4412c4..516504cf0ea5 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -10,7 +10,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
>  {
>  	double val;
>  
> -	if (expr__parse(&val, ctx, e))
> +	if (expr__parse(&val, ctx, e, 1))
>  		TEST_ASSERT_VAL("parse test failed", 0);
>  	TEST_ASSERT_VAL("unexpected value", val == val2);
>  	return 0;
> @@ -44,15 +44,15 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  		return ret;
>  
>  	p = "FOO/0";
> -	ret = expr__parse(&val, &ctx, p);
> +	ret = expr__parse(&val, &ctx, p, 1);
>  	TEST_ASSERT_VAL("division by zero", ret == -1);
>  
>  	p = "BAR/";
> -	ret = expr__parse(&val, &ctx, p);
> +	ret = expr__parse(&val, &ctx, p, 1);
>  	TEST_ASSERT_VAL("missing operand", ret == -1);
>  
>  	TEST_ASSERT_VAL("find other",
> -			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other) == 0);
> +			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other, 1) == 0);
>  	TEST_ASSERT_VAL("find other", num_other == 3);
>  	TEST_ASSERT_VAL("find other", !strcmp(other[0], "BAR"));
>  	TEST_ASSERT_VAL("find other", !strcmp(other[1], "BAZ"));

could we add test case for runtime param > 1 in here?
expr_parse should return value that would depend on this value..

jirka
