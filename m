Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48014C07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31721613BF
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 15:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhGNPNz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232334AbhGNPNy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 11:13:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A75E8613CB;
        Wed, 14 Jul 2021 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626275463;
        bh=KJFJoEp7lD7CvBN7iUCjcgQGenAYo3/mAq8Pnw9aNlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LClOCirG2d1CZvnFhpzouT5dvD57EcQyEJe/k+83lBkA6/yzYPwfIA2s9KORP4jHY
         8A90yVGxYP876ru9msx9iwOBIZ3fY1vtx2PE7YYVfpwBgHsShN1B6VOceeundRw48/
         LOLfc0doxSjxlcg6iM5hOWZapGRS9G14j1eGI1nu10BczqKgQEDumHVf7zpwfUjD4P
         2cYYCSsT7g1FfcJWeg1R1zK8qfMDDxHznyOmGxJ/pkbCSznGBfwgRxGRnHS773Usg6
         V7QOmJK7X0NswDlgoRsq6azEW/tIT1S+b+fJCR5fG/NdKrr+4VfVUINf+jLacK1ctI
         I7QWBD7jNd2ig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68EA6403F2; Wed, 14 Jul 2021 12:10:59 -0300 (-03)
Date:   Wed, 14 Jul 2021 12:10:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 02/10] perf tests: add test for workqueue
Message-ID: <YO7+g3wvtvJ+Zm5o@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <333e2e3986d32cf8894105f149abb543a84ec91c.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333e2e3986d32cf8894105f149abb543a84ec91c.1626177381.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 02:11:13PM +0200, Riccardo Mancini escreveu:
> It will have subtests testing threadpool and workqueue separately.
> This patch only introduces the first subtest, checking that the
> threadpool is correctly created and destructed.
> This test will be expanded when new functions are added in next
> patches.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   9 +++
>  tools/perf/tests/tests.h        |   3 +
>  tools/perf/tests/workqueue.c    | 113 ++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 tools/perf/tests/workqueue.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 650aec19d49052ca..eda6c78a37cfbc13 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -64,6 +64,7 @@ perf-y += parse-metric.o
>  perf-y += pe-file-parsing.o
>  perf-y += expand-cgroup.o
>  perf-y += perf-time-to-tsc.o
> +perf-y += workqueue.o
>  
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>  	$(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 5e6242576236325c..2ff5d38ed83a723d 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -360,6 +360,15 @@ static struct test generic_tests[] = {
>  		.func = test__perf_time_to_tsc,
>  		.is_supported = test__tsc_is_supported,
>  	},
> +	{
> +		.desc = "Test workqueue lib",
> +		.func = test__workqueue,
> +		.subtest = {
> +			.skip_if_fail	= false,
> +			.get_nr		= test__workqueue_subtest_get_nr,
> +			.get_desc	= test__workqueue_subtest_get_desc,
> +		}
> +	},
>  	{
>  		.func = NULL,
>  	},
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 1100dd55b657b779..9ca67113a7402463 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -127,6 +127,9 @@ int test__parse_metric(struct test *test, int subtest);
>  int test__pe_file_parsing(struct test *test, int subtest);
>  int test__expand_cgroup_events(struct test *test, int subtest);
>  int test__perf_time_to_tsc(struct test *test, int subtest);
> +int test__workqueue(struct test *test, int subtest);
> +const char *test__workqueue_subtest_get_desc(int subtest);
> +int test__workqueue_subtest_get_nr(void);
>  
>  bool test__bp_signal_is_supported(void);
>  bool test__bp_account_is_supported(void);
> diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
> new file mode 100644
> index 0000000000000000..1bd4d78c13eb3b14
> --- /dev/null
> +++ b/tools/perf/tests/workqueue.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include "tests.h"
> +#include "util/debug.h"
> +#include "util/workqueue/threadpool.h"
> +
> +struct threadpool_test_args_t {
> +	int pool_size;
> +};
> +
> +static int __threadpool__prepare(struct threadpool_struct **pool, int pool_size)
> +{
> +	*pool = create_threadpool(pool_size);
> +	TEST_ASSERT_VAL("threadpool creation failure", *pool != NULL);
> +	TEST_ASSERT_VAL("threadpool size is wrong",
> +			threadpool_size(*pool) == pool_size);
> +
> +	return 0;
> +}
> +
> +static int __threadpool__teardown(struct threadpool_struct *pool)
> +{
> +	destroy_threadpool(pool);
> +
> +	return 0;
> +}
> +
> +
> +static int __test__threadpool(void *_args)
> +{
> +	struct threadpool_test_args_t *args = _args;
> +	struct threadpool_struct *pool;
> +	int ret;
> +
> +	ret = __threadpool__prepare(&pool, args->pool_size);

Turn the last three lines into one;

	int ret = __threadpool__prepare(&pool, args->pool_size);

> +	if (ret)
> +		return ret;
> +
> +	ret = __threadpool__teardown(pool);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Humm, will you add something here in the following csets? Otherwise turn
these 5 lines into one:

	return __threadpool__teardown(pool);

> +}
> +
> +static const struct threadpool_test_args_t threadpool_test_args[] = {
> +	{
> +		.pool_size = 1
> +	},
> +	{
> +		.pool_size = 2
> +	},
> +	{
> +		.pool_size = 4
> +	},
> +	{
> +		.pool_size = 8
> +	},
> +	{
> +		.pool_size = 16
> +	}
> +};
> +
> +struct test_case {
> +	const char *desc;
> +	int (*func)(void *args);
> +	void *args;
> +	int n_args;
> +	int arg_size;
> +};
> +
> +static struct test_case workqueue_testcase_table[] = {
> +	{
> +		.desc = "Threadpool",
> +		.func = __test__threadpool,
> +		.args = (void *) threadpool_test_args,
> +		.n_args = (int)ARRAY_SIZE(threadpool_test_args),
> +		.arg_size = sizeof(struct threadpool_test_args_t)
> +	}
> +};
> +
> +
> +int test__workqueue(struct test *test __maybe_unused, int i)
> +{
> +	int j, ret = 0;
> +	struct test_case *tc;
> +
> +	if (i < 0 || i >= (int)ARRAY_SIZE(workqueue_testcase_table))
> +		return -1;
> +
> +	tc = &workqueue_testcase_table[i];
> +
> +	for (j = 0; j < tc->n_args; j++) {
> +		ret = tc->func(tc->args + (j*tc->arg_size));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +int test__workqueue_subtest_get_nr(void)
> +{
> +	return (int)ARRAY_SIZE(workqueue_testcase_table);
> +}
> +
> +const char *test__workqueue_subtest_get_desc(int i)
> +{
> +	if (i < 0 || i >= (int)ARRAY_SIZE(workqueue_testcase_table))
> +		return NULL;
> +	return workqueue_testcase_table[i].desc;
> +}
> -- 
> 2.31.1
> 

-- 

- Arnaldo
