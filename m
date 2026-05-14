Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B738BF72
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789169; cv=none; b=u7I7p0UIwlfqP7/fE+VZW4jr2wF0TwyM2OTC4bxOeTp2/97SRpy8AtHLSwDLJSnliWjb9faCuQMCncW0Qfo6fSo/nhp4fqJK+4+DBIPxpmv932srYftLmQ2CdTng3c72Oczk0u4E6iReKRvB+uxo40psDhOef/l0kOV0ZPkAaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789169; c=relaxed/simple;
	bh=0zoyu0jALz+o2ga/t19ZoeRx1Zcnj2yMs53nZcR8v3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lE24C/z1RbGJx2gc4eEvzsIJv4XgP417vvIcBUeCIxVXb7D1rSCxt1rBxRFCc+PQdduSn0N4xanjC5oNTXrKUXtRd44Zk7U9a4J4Q+39NeWZFKXns9M7fq1lRq5/AOgmgFupqmn+scZ7K7Z4hTI6wiNOhTb3C/FZTfXyVVz47CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGNsEeYr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGNsEeYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B176C2BCB3;
	Thu, 14 May 2026 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778789169;
	bh=0zoyu0jALz+o2ga/t19ZoeRx1Zcnj2yMs53nZcR8v3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UGNsEeYrY7mnQEo1n4ib+WwTswE3O3P8bwMQ3uGU/EqSKllxTElSPwM1Mg9grRJ+W
	 E5rgV3OB9T50dMqLzr1z6TbazI/WyLyrVw50DfNP5xEhUspck7jpAn4hB4UsWRdIVu
	 oLebG7vaP0m8IKBJokS/RMY6nOcByVYzmw5ZfC39+GOvmXhLmgM4Jlg7IesdBZHK1P
	 oTPUCzXB4JScgx7+PZFtu0P047v7oneUSO7zurhOAXJG43oB1ePrv7XaG0vv12fBr4
	 Lq8LZluh6xPMCmLOoFGxRpxWVlY37+jLIKN2lLtRjew+nIdYk4JmUqfV8NecK8nfr+
	 cVnHq+japQNhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] selftests/perf_events: Add test for refresh
 limit signals
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514-arm_cs_clean_perf_handle-v2-1-cbb29c3b3661@arm.com>
References: <20260514-arm_cs_clean_perf_handle-v2-1-cbb29c3b3661@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 20:06:07 +0000
Message-Id: <20260514200609.0B176C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Missing <sys/syscall.h> include for syscall() and __NR_perf_event_o=
pen
- [Low] FIXTURE_TEARDOWN unconditionally operates on potentially invalid fi=
le descriptor
- [Low] Using EXPECT_EQ for sigaction may cause an ungraceful test crash on=
 setup failure
--

commit 3f198b4c551c8f0caf35b8f6bc25feee2904073b
Author: Leo Yan <leo.yan@arm.com>

selftests/perf_events: Add test for refresh limit signals

This commit adds a test to verify PERF_EVENT_IOC_REFRESH with a
task-clock software event. It uses a real-time signal to queue
notifications and verifies that exactly one POLL_HUP notification is
delivered per iteration when the refresh count reaches zero.

> diff --git a/tools/testing/selftests/perf_events/refresh_signal.c b/tools=
/testing/selftests/perf_events/refresh_signal.c
> new file mode 100644
> index 0000000000000..5519ea7b56f9d
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/refresh_signal.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <fcntl.h>
> +#include <linux/perf_event.h>
> +#include <poll.h>
> +#include <signal.h>
> +#include <sys/ioctl.h>
> +#include <time.h>
> +
> +#include "../kselftest_harness.h"

Is it necessary to explicitly include <sys/syscall.h> and <unistd.h>
here?

The test uses syscall() and __NR_perf_event_open, and relying on
implicit transitive includes from kselftest_harness.h might lead to
compilation failures on some architectures or libc implementations.

[ ... ]

> +FIXTURE_SETUP(refresh_signal)
> +{
> +	struct sigaction sa =3D { 0 };
> +	struct perf_event_attr attr =3D { 0 };
> +
> +	sa.sa_sigaction =3D sigio_handler;
> +	sa.sa_flags =3D SA_SIGINFO;
> +	sigemptyset(&sa.sa_mask);
> +
> +	/* Use a real-time signal so notifications are reliably queued */
> +	EXPECT_EQ(sigaction(RT_SIG, &sa, &self->old_sa), 0);

If sigaction() fails, EXPECT_EQ logs a failure but allows the setup to
continue.

When the perf event triggers the first RT_SIG, the process will lack a
custom handler and the default action will terminate the test program.

Would it be safer to use ASSERT_EQ here so the test aborts cleanly on
setup failure?

[ ... ]

> +	self->fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> +	ASSERT_NE(self->fd, -1);
> +
> +	/* Enable async notification */
> +	ASSERT_EQ(fcntl(self->fd, F_SETFL, fcntl(self->fd, F_GETFL) | O_ASYNC),=
 0);
> +
> +	/* Receive the signal for current process */
> +	ASSERT_EQ(fcntl(self->fd, F_SETOWN, getpid()), 0);
> +
> +	/* Use signo instead of the default SIGIO */
> +	ASSERT_EQ(fcntl(self->fd, F_SETSIG, RT_SIG), 0);
> +}
> +
> +FIXTURE_TEARDOWN(refresh_signal)
> +{
> +	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
> +
> +	close(self->fd);
> +	sigaction(RT_SIG, &self->old_sa, NULL);
> +}

If syscall(__NR_perf_event_open) fails during FIXTURE_SETUP, self->fd is
assigned -1 and the setup aborts via ASSERT_NE.

However, the kselftest framework still executes FIXTURE_TEARDOWN, which
will unconditionally call ioctl() and close() on -1. Could this generate
additional and confusing test failure logs?

Should we verify if self->fd >=3D 0 before attempting to operate on it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-arm_cs_cle=
an_perf_handle-v2-0-cbb29c3b3661@arm.com?part=3D1
