Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F59349CDD
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719778; cv=none; b=FiM8CmNUYeW01c+yQOiS9Q9APax1MX0lpvAWxUKHiK07aTMXktHX6S9Ny6T1vgseLcxKJfei0QyqK6pIMD2Aa+mZ9kXz1erNTpv66E1YTHYewcrWOyJ1zT0KJLzuXTN9k/lfZZlZOMaHpW4Y/kcsXIe2x8yo0IGHjqQlTubEcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719778; c=relaxed/simple;
	bh=ftf0PMKfdHCNX1Jm8KL3k6A72HhWpiua3ZLhFVVKgQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtYAXiVvaDv7NkRCMDO7I1AEkD+kEcfBcsDOGm/b29jscgBnfQuaM2PNYMkWDtOEhr+nEmqHi39b+41VPmoLCWcnF9bWSdnprCXCeFBT/SjOchmg8OOxo2oh3cWTcnmm9mmCaIhBFKEdN143jxUKJ46vJu8ZI6IbDd0aWNT71wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF/7hq5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF/7hq5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA3E1F000E9;
	Fri, 14 Aug 2026 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719777;
	bh=CDDvOUtvmjkXuhQkqyhiimZQ3shgmJ05CLcQa1LeV4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LF/7hq5qQBLMJx+gp3oFaJ6DDaXjwzmPjAUqJbrKn0BJclgE2K1688Rc80loqXgaL
	 uTJKKyjh3FzI0JPk7eHKXhShnuezyvG+5uoKkyS/6n/IfN/Ba14rrudeWpdRAM3yn4
	 fWUc+5EqyJ6yUJEEZRPQh0tbWH5BjDcVJWoS9XKK9PnqCE4wFWHhQG+jJ4SM+3b//4
	 lsi7aqt9im7p8UznKdqIfiUS+bKRWOuihmc3Ck7GM08eeGGMZ3sj36YtvekSBWEx2j
	 LNO2kMrog++eD+o7XIGF47eLYq++wpp0FN2Gw1mkHGYPKbOlxH8TK8i8viM92YWxA8
	 gLdUSPrHasEIg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/5] perf/core: add KUnit tests for AUX
 kernel-consumer API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260814144927.489172-4-kunwu.chan@linux.dev>
References: <20260814144927.489172-1-kunwu.chan@linux.dev>
 <20260814144927.489172-4-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:02:56 +0000
Message-Id: <20260814150256.ECA3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] KUnit assertions (`KUNIT_ASSERT_*`) and `kunit_skip()` abort tests=
 immediately, leaking resources and causing stack Use-After-Free.
- [High] Race between `atomic_dec_and_test()` and lockless `wait_event()` c=
auses a stack Use-After-Free in `test_concurrent_release()`.
- [High] Test cases use non-fatal `KUNIT_EXPECT_*` macros for critical setu=
p steps, resulting in uninitialized stack usage and NULL pointer dereferenc=
es.
- [High] `test_concurrent_release` triggers a `refcount_t` underflow kernel=
 WARNING via concurrent `perf_event_release_aux()` calls.
- [High] Error path in `test_concurrent_release` calls `kthread_stop()` on =
natively exiting threads, leading to Use-After-Free.
- [Medium] Dead code in `test_buffer_full_stops_producer` masks actual API =
behavior and fails to enforce expected outcomes.
--

--- Patch [3]: [RFC PATCH 3/5] perf/core: add KUnit tests for AUX kernel-co=
nsumer API ---
commit 7ac72ec86c4a7abdecf89cc4cddc373879a7f3b2
Author: Lian Wang <lianux.mm@gmail.com>

perf/core: add KUnit tests for AUX kernel-consumer API

Adds a KUnit test suite (perf_aux_kernel) for the perf_event_setup_aux() and
related functions. Registers a self-contained dummy AUX PMU to run tests
deterministically without hardware. Includes 39 test cases covering lifecyc=
le,
writers, ring buffer accessors, and concurrency.

> diff --git a/kernel/events/aux_kernel_test.c b/kernel/events/aux_kernel_t=
est.c
> new file mode 100644
> index 0000000000000..0b5f787c59799
> --- /dev/null
> +++ b/kernel/events/aux_kernel_test.c
[ ... ]
> +static void test_copy_full_window(struct kunit *test)
> +{
> +	struct perf_event *event =3D aux_test_create_event();
[ ... ]
> +	ret =3D perf_event_setup_aux(event, 1, 0);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +
> +	head =3D aux_test_produce(event, buf_size / 2);
> +	KUNIT_EXPECT_GT(test, head, 0);
> +
> +	buf =3D kunit_kmalloc(test, head, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);

[Severity: High]
Does this assertion leak the perf_event structure?

KUnit assertions like KUNIT_ASSERT_NOT_ERR_OR_NULL abort the test immediate=
ly
by throwing a KUnit exception. If this allocation fails after
aux_test_create_event() succeeds, the test will abort without calling
perf_event_release_kernel(), causing a permanent resource leak.

[ ... ]
> +static void test_buffer_full_stops_producer(struct kunit *test)
> +{
[ ... ]
> +	head =3D aux_test_produce(event, buf_size);
> +	KUNIT_EXPECT_GT(test, head, 0);
> +
> +	addr =3D perf_aux_output_begin(&handle, event);
> +	if (addr) {
> +		KUNIT_EXPECT_EQ(test, 0, handle.size);
> +		perf_aux_output_end(&handle, 0);
> +	}

[Severity: Medium]
Does this block fail to verify the expected behavior?

When the buffer is full, perf_aux_output_begin() correctly returns NULL.
Because addr is NULL, this conditional block is skipped entirely, turning t=
he
core validation into dead code. This allows the test to silently pass even =
if
perf_aux_output_begin() incorrectly returns a non-NULL pointer with an
arbitrary size.

Would it be better to explicitly assert KUNIT_EXPECT_NULL(test, addr)?

[ ... ]
> +static void test_user_kernel_coexistence(struct kunit *test)
> +{
[ ... ]
> +	/* Event B: start with kernel setup, then simulate userspace */
> +	ret =3D perf_event_setup_aux(ev_b, 1, 0);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +
> +	/* Simulate userspace ownership: swap refcounts on B's rb.
> +	 * perf_mmap() would set aux_mmap_count=3D1 for a userspace event.
> +	 */
> +	refcount_set(&ev_b->rb->aux_mmap_count, 1);

[Severity: High]
Can this result in a NULL pointer dereference?

The KUNIT_EXPECT_EQ macro logs failures but allows execution to continue.
If perf_event_setup_aux() fails, ev_b->rb will be NULL. The test then proce=
eds
to evaluate refcount_set(&ev_b->rb->aux_mmap_count, 1), which dereferences =
it.

Should KUNIT_ASSERT_EQ be used for critical setup steps?

[ ... ]
> +	/* Produce on A =E2=80=94 B's head stays 0 */
> +	addr =3D perf_aux_output_begin(&handle_a, ev_a);
> +	KUNIT_EXPECT_NOT_NULL(test, addr);
> +	perf_aux_output_end(&handle_a, 512);

[Severity: High]
Can this sequence cause a kernel panic?

Similar to the previous setup step, if perf_aux_output_begin() fails and
returns NULL, handle_a remains uninitialized since KUNIT_EXPECT_NOT_NULL do=
es
not halt the test.

Continuing past the failure passes this uninitialized handle to
perf_aux_output_end(), which will dereference garbage data from handle_a.rb.

[ ... ]
> +struct concurrent_release_ctx {
> +	struct perf_event *event;
> +	atomic_t count;
> +	wait_queue_head_t wq;
> +};
> +
> +static int concurrent_release_thread(void *data)
> +{
> +	struct concurrent_release_ctx *ctx =3D data;
> +
> +	perf_event_release_aux(ctx->event);
> +
> +	if (atomic_dec_and_test(&ctx->count))
> +		wake_up(&ctx->wq);
> +	return 0;
> +}

[Severity: High]
Can decoupling the atomic decrement and the wake_up() call create a stack
use-after-free window?

The main thread waits for worker threads using wait_event(), which evaluates
its condition locklessly. If the last worker thread executes
atomic_dec_and_test(&ctx->count), setting it to 0, the main thread can obse=
rve
the 0, break out of wait_event(), and return from the function before the
worker executes wake_up(&ctx->wq).

Returning from test_concurrent_release() destroys the ctx struct on the sta=
ck,
meaning the worker thread will then call wake_up() on a destroyed stack fra=
me.

Could this be avoided by using the struct completion API, which is explicit=
ly
designed to prevent this race for on-stack waiters?

[ ... ]
> +static void test_concurrent_release(struct kunit *test)
> +{
> +	struct perf_event *event =3D aux_test_create_event();
> +	struct concurrent_release_ctx ctx;
> +	struct task_struct *threads[2];
> +	int ret, i;
[ ... ]
> +	for (i =3D 0; i < ARRAY_SIZE(threads); i++) {
> +		threads[i] =3D kthread_run(concurrent_release_thread, &ctx,
> +					 "aux_crel_%d", i);

[Severity: High]
Does intentionally launching concurrent releases here trigger a refcount_t
underflow warning?

In perf_event_release_aux() in core.c, the check
!refcount_read(&rb->aux_kernel_count) is performed locklessly. Both worker
threads can read aux_kernel_count as 1 and proceed to call
refcount_dec_and_mutex_lock().

The first thread successfully decrements the count from 1 to 0. The second
thread subsequently calls refcount_dec_and_mutex_lock() on a count of 0,
which triggers a REFCOUNT_WARN("underflow; use-after-free.") inside
__refcount_dec_and_test().

Is it intended for a KUnit test to trigger kernel warnings on a successful
path?

> +		if (IS_ERR_OR_NULL(threads[i])) {
> +			kunit_skip(test, "failed to create kthread");

[Severity: High]
Can kunit_skip() cause a stack use-after-free if a thread is already runnin=
g?

kunit_skip() terminates the test immediately by throwing a KUnit exception,
bypassing any subsequent cleanup code. This means the test function returns
instantly, destroying the ctx struct allocated on the main thread's stack.

If an earlier thread was successfully spawned and is still running, it will
access ctx->event and ctx->count on the destroyed stack frame.

> +			while (--i >=3D 0)
> +				kthread_stop(threads[i]);

[Severity: High]
Does kthread_stop() cause a use-after-free on natively exiting threads?

The concurrent_release_thread function does not check kthread_should_stop();
it simply executes and naturally returns 0. When a thread naturally exits, =
its
task_struct is reaped.

Calling kthread_stop() here on a potentially reaped task_struct will access
freed memory inside get_task_struct(). While currently masked as dead code =
due
to kunit_skip() aborting execution above, this cleanup logic appears unsafe.

> +			perf_event_release_aux(event);
> +			perf_event_release_kernel(event);
> +			return;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144927.4891=
72-1-kunwu.chan@linux.dev?part=3D3
