Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793318139;
	b=BcL0OLHEaHZks6l1ygqCaR9tDyddFQn1jinu7k96+ulYIU3mTZeIZb67HDfHA4/TlXL5
	 iBSn8U+InZyr717/RRZ/SsPDQSz2B8BsJrKI3+YT23fWQsrrB0Tu5JIO9ldniACEuTFUG
	 PcDfQI5UuVrkkJ7O2nX8OQGaeffe8wnPpfVvDGGhdoma5jJ0QEertWOm8QjRJJoRz7WoK
	 eZt3akwZSNTKLKnYNgjfduu1p08xvg19myax7xAHJRSMAzOHRko2ja/81/MkAOEk5HAxs
	 shoAosuTbCq2W7pJKkbBgMtm/P10F9h2ryRsKtC1IjJapGLjbd2XckuMwxRR8FAbFiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318139;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=AMezWfxj83Cg3T8Y7h4Dr+n4iaXJKaZeceRX/U320L4=;
	b=pQOJGKAJH2vwUfutZAEp3Z/n4VwYCtGmvF9a4jLaco01nAicnDiehXUw1/asio9smpvp
	 bnhnNZOWNey3QtwYjPi4FGTp7lzgX9O6Fttnjd74JR4p/rD8gEzRXK3AG39XxM+2w+f8o
	 6JxrvrGOzToNd9WaVCg7PHnoUsLsgFzGc+c+dBqCp3kGubnwMg+lVApJbciVfvSX6O85m
	 8nDTZiC2DQomFDifkI2v5TDvGn4s1XsbXlIxehktNKZUb1zUm4tBeN3GhsXRYGORYMA9U
	 UW4fwruUxomUouzt0mZ5JZcy8waNJO/2zaFLE0+xYemaY4A8ee0sOZZOyozESIGmm+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b="n7/w25w8";
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAE606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 23:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EDAE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=n7/w25w8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793318135; x=1793577335;
	bh=AMezWfxj83Cg3T8Y7h4Dr+n4iaXJKaZeceRX/U320L4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=n7/w25w8HxG78XAKHv0ACwy8aeETiSKZ8GeC/hUWJ2XoWG10IGxCEsK+l8ejTKF3C
	 ECrHpm9lGF8WDSY4EAyeP7Fl0fbma/BaGoiQUZnOQpPNZlj6+CfGFZsIR9Yos30Euo
	 0vBACplCg+burAmtMAUMD7GDR+RFYe5twsy8bdIiNTYBwPL8cDqaRbnbJMYN/vJ2U2
	 /5lYlOfEqUAz2dbj5bnSjaU3IxBpz2YhOulpacOCZxoKeKGIjdIZoVlDf0QEvgPIgc
	 q3XS47UppJ2GWYMW5s0Kb8iIc9RREGcmFwTwXjyoh3dDITE2jicASlruyelJd4maGH
	 xuwwEodmY+ugw==
Date: Thu, 29 Oct 2026 23:55:27 +0000
To: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
From: Paul Moses <p@1g4.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, kan.liang@intel.com, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: Re: [PATCH 1/2] perf mmap: Use the head selected by read_init
Message-ID: <BC1sJClSvdQkAftuo53KsidGZTTOLHrxfa6XDLqGWykGCWsPr4V8WdVFE7rk-cVf-BEduiokioSSsvODnpnpbSndeOiQCOTPIi1C35t3DaU=@1g4.org>
In-Reply-To: <20261020171946.3593127-2-p@1g4.org>
References: <20261020171946.3593127-1-p@1g4.org> <20261020171946.3593127-2-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d7020e91c59fa4837ae853d9cf19d115a86e42dd
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 20th, 2026 at 12:20 PM, Paul Moses <p@1g4.org> wrote:

> perf_mmap__push() reads the producer head before calling
> perf_mmap__read_init(), which reads it again to select the range to copy.
>=20
> If the producer advances between those reads, push() copies through the
> newer head but stores the earlier head in prev. The next drain starts at
> that earlier position and can write the same records to perf.data again.
>=20
> Use the head selected by read_init(): end for forward buffers and start
> for overwrite buffers. Save it before the copy loop advances start so
> prev matches the range that was copied.
>=20
> Fixes: 8872481bd048 ("perf mmap: Introduce perf_mmap__read_init()")
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
>  tools/perf/util/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 358e70c4f3edd077c9752115329f29040f1c2a76..6dcc4a9304b926c4a8d4f401e=
40bfd79d18dd199 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -330,7 +330,7 @@ int mmap__mmap(struct mmap *map, struct mmap_params *=
mp, int fd, struct perf_cpu
>  int perf_mmap__push(struct mmap *md, void *to,
>  =09=09    int push(struct mmap *map, void *to, void *buf, size_t size))
>  {
> -=09u64 head =3D perf_mmap__read_head(&md->core);
> +=09u64 head;
>  =09unsigned char *data =3D md->core.base + page_size;
>  =09unsigned long size;
>  =09void *buf;
> @@ -340,6 +340,7 @@ int perf_mmap__push(struct mmap *md, void *to,
>  =09if (rc < 0)
>  =09=09return (rc =3D=3D -EAGAIN) ? 1 : -1;
> =20
> +=09head =3D md->core.overwrite ? md->core.start : md->core.end;
>  =09size =3D md->core.end - md->core.start;
> =20
>  =09if ((md->core.start & md->core.mask) + size !=3D (md->core.end & md->=
core.mask)) {
> --=20
> 2.56.GIT
>=20
>=20

This originally occurred while profiling packet flows and a duplicate
marker was "luckily" detected by validation. It might be statistically=20
insignificant to most workloads, but when looking at sequences, it is=20
a real pain.

Below is a more standardized reproduction of the bug than originally=20
used.

Let me know if anything else is needed.

results:

  unpatched=20
  BUG: push=3D17274 copied=3D[120,144) saved_prev=3D120 replay_bytes=3D24
  replay: records=3D64548 unique=3D49974 duplicates=3D14574 cursor_mismatch=
es=3D14574 capture_bytes=3D1549152
  replay: result=3DFAIL

  patched=20
  replay: records=3D49994 unique=3D49994 duplicates=3D0 cursor_mismatches=
=3D0 capture_bytes=3D1199856
  replay: result=3DPASS

  Under GDB, two unpatched runs both reported the first push as:

  BUG: push=3D0 copied=3D[0,48816) saved_prev=3D0 replay_bytes=3D48816


# Force the two producer-head reads in perf_mmap__push() to straddle
# producer progress. In the parent, the first read happens in
# perf_mmap__push() and the second in perf_mmap__read_init(). The child is
# detached and keeps sampling while GDB sleeps in the parent.
#
#   gdb -q -batch -x replay.gdb ./replay
#
# The breakpoint is disabled after its first hit so only the first push is
# delayed.

set pagination off
set confirm off
set follow-fork-mode parent
set detach-on-fork on

break perf_mmap__read_init
commands
  silent
  disable
  shell sleep 0.2
  continue
end

run

# Preserve the PASS/FAIL status as GDB's exit status.
if $_exitcode !=3D 0
  quit 1
end
quit



/*
 * perf_mmap__push() saves a head older than the range it
 * copies, so the next push copies the same records again.
 *
 * A child runs a busy loop for five seconds. The parent samples it with
 * PERF_COUNT_SW_CPU_CLOCK, maps the real perf ring, and calls perf_mmap__p=
ush()
 * while the child runs.
 *
 * Each successful forward push that copies data must leave
 * core.prev =3D=3D core.end.  The capture loop checks that invariant direc=
tly.
 * Every copied segment is tagged with its push number, so duplicate record=
s
 * identify the two pushes that copied them; the record hash includes the P=
ID,
 * TID, and perf timestamp.
 *
 * replay.gdb widens the window between the two producer-head reads without
 * changing the implementation.
 *
 * Build:
 *   K=3D/usr/src/linux-7.x
 *   cc -O2 -g -ffunction-sections -fdata-sections -Wl,--gc-sections \
 *      -D_GNU_SOURCE \
 *      -I$K/tools/lib/perf/include -I$K/tools/lib/perf -I$K/tools/lib \
 *      -I$K/tools/include -I$K/tools/arch/x86/include \
 *      -I$K/tools/arch/x86/include/uapi -I$K/tools/include/uapi \
 *      -I$K/tools/perf -I$K/tools/perf/util \
 *      replay.c $K/tools/perf/util/mmap.c $K/tools/lib/perf/mmap.c \
 *      $K/tools/lib/perf/core.c $K/tools/lib/perf/lib.c \
 *      $K/tools/lib/zalloc.c -o replay
 */

#include <errno.h>
#include <inttypes.h>
#include <linux/perf_event.h>
#include <poll.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <perf/core.h>
#include <perf/event.h>
#include <perf/mmap.h>
#include <internal/lib.h>
#include <internal/mmap.h>
#include "mmap.h"

#define RING_PAGES=09128
#define WORKLOAD_MS=095000
#define SAMPLE_PERIOD_NS=09100000
#define CAPTURE_TIMEOUT_MS 30000

static volatile sig_atomic_t interrupted;

static void interrupt_handler(int sig)
{
=09(void)sig;
=09interrupted =3D 1;
}

struct push_seg {
=09size_t=09=09off;
=09unsigned long=09push;
};

struct capture {
=09unsigned char=09*buf;
=09size_t=09=09len;
=09size_t=09=09cap;
=09struct push_seg=09*segs;
=09size_t=09=09nsegs;
=09size_t=09=09segcap;
=09unsigned long=09push;
};

struct rec {
=09uint64_t=09hash;
=09size_t=09=09off;
=09uint32_t=09size;
=09unsigned long=09push;
};

/* PERF_SAMPLE_TID | PERF_SAMPLE_TIME, in ABI order. */
struct clock_sample {
=09struct perf_event_header header;
=09uint32_t pid, tid;
=09uint64_t time;
};

static void die(const char *what)
{
=09fprintf(stderr, "%s: %s\n", what, strerror(errno));
=09exit(1);
}

static int64_t now_ms(void)
{
=09struct timespec ts;

=09if (clock_gettime(CLOCK_MONOTONIC, &ts) < 0)
=09=09return -1;
=09return (int64_t)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
}

static int worker_main(int ready_fd, int go_fd)
{
=09volatile uint64_t work =3D 0;
=09int64_t now, deadline;
=09char byte;

=09if (write(ready_fd, "R", 1) !=3D 1)
=09=09die("write ready");
=09if (read(go_fd, &byte, 1) !=3D 1 || byte !=3D 'G') {
=09=09fprintf(stderr, "worker did not receive start command\n");
=09=09return 1;
=09}

=09now =3D now_ms();
=09if (now < 0)
=09=09die("clock_gettime");
=09deadline =3D now + WORKLOAD_MS;
=09do {
=09=09unsigned int i;

=09=09for (i =3D 0; i < 65536; i++)
=09=09=09work++;
=09=09now =3D now_ms();
=09=09if (now < 0)
=09=09=09die("clock_gettime");
=09} while (!interrupted && now < deadline);
=09return interrupted ? 1 : 0;
}

static int open_cpu_clock(pid_t pid)
{
=09struct perf_event_attr attr;
=09int fd;

=09memset(&attr, 0, sizeof(attr));
=09attr.type =3D PERF_TYPE_SOFTWARE;
=09attr.size =3D sizeof(attr);
=09attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
=09attr.sample_period =3D SAMPLE_PERIOD_NS;
=09attr.sample_type =3D PERF_SAMPLE_TID | PERF_SAMPLE_TIME;
=09attr.disabled =3D 1;
=09attr.exclude_kernel =3D 1;
=09attr.exclude_hv =3D 1;

=09fd =3D syscall(__NR_perf_event_open, &attr, pid, -1, -1, 0);
=09if (fd < 0) {
=09=09fprintf(stderr, "perf_event_open(%d): %s\n", pid, strerror(errno));
=09=09return -1;
=09}

=09return fd;
}

static int map_ring(int fd, struct perf_mmap *map)
{
=09struct perf_mmap_param mp =3D {
=09=09.prot =3D PROT_READ | PROT_WRITE,
=09=09.mask =3D RING_PAGES * page_size - 1,
=09};

=09perf_mmap__init(map, NULL, false, NULL);
=09if (perf_mmap__mmap(map, &mp, fd, (struct perf_cpu){ .cpu =3D 0 })) {
=09=09fprintf(stderr, "perf_mmap__mmap: %s\n", strerror(errno));
=09=09return -1;
=09}
=09refcount_set(&map->refcnt, 2);
=09return 0;
}

static int capture_push(struct mmap *map, void *to, void *buf, size_t size)
{
=09struct capture *c =3D to;
=09size_t cap;
=09void *p;

=09(void)map;
=09if (!size)
=09=09return 0;
=09if (c->len + size < c->len)
=09=09return -1;
=09if (c->len + size > c->cap) {
=09=09cap =3D c->cap ? c->cap : 65536;
=09=09while (cap < c->len + size)
=09=09=09cap *=3D 2;
=09=09p =3D realloc(c->buf, cap);
=09=09if (!p)
=09=09=09return -1;
=09=09c->buf =3D p;
=09=09c->cap =3D cap;
=09}
=09if (c->nsegs =3D=3D c->segcap) {
=09=09size_t segcap =3D c->segcap ? c->segcap * 2 : 4096;
=09=09struct push_seg *segs;

=09=09segs =3D realloc(c->segs, segcap * sizeof(*segs));
=09=09if (!segs)
=09=09=09return -1;
=09=09c->segs =3D segs;
=09=09c->segcap =3D segcap;
=09}
=09memcpy(c->buf + c->len, buf, size);
=09c->segs[c->nsegs].off =3D c->len;
=09c->segs[c->nsegs].push =3D c->push;
=09c->nsegs++;
=09c->len +=3D size;
=09return 0;
}

static uint64_t hash_record(const unsigned char *p, size_t len)
{
=09uint64_t h =3D 1469598103934665603ULL;
=09size_t i;

=09for (i =3D 0; i < len; i++) {
=09=09h ^=3D p[i];
=09=09h *=3D 1099511628211ULL;
=09}
=09return h;
}

static int rec_cmp(const void *a, const void *b, void *arg)
{
=09const struct rec *ra =3D a, *rb =3D b;
=09const unsigned char *buf =3D arg;

=09if (ra->hash < rb->hash)
=09=09return -1;
=09if (ra->hash > rb->hash)
=09=09return 1;
=09if (ra->size < rb->size)
=09=09return -1;
=09if (ra->size > rb->size)
=09=09return 1;
=09return memcmp(buf + ra->off, buf + rb->off, ra->size);
}

static unsigned long push_for_offset(const struct capture *c, size_t off)
{
=09size_t lo =3D 0, hi =3D c->nsegs;

=09while (lo < hi) {
=09=09size_t mid =3D lo + (hi - lo) / 2;

=09=09if (c->segs[mid].off <=3D off)
=09=09=09lo =3D mid + 1;
=09=09else
=09=09=09hi =3D mid;
=09}
=09return lo ? c->segs[lo - 1].push : 0;
}

static uint64_t time_of(const unsigned char *rec)
{
=09struct clock_sample sample;

=09memcpy(&sample, rec, sizeof(sample));
=09return sample.time;
}

static int report(const struct capture *c, unsigned long cursor_mismatches)
{
=09struct rec *recs =3D NULL;
=09size_t nrec =3D 0, cap =3D 0, off =3D 0;
=09unsigned long total =3D 0, unique =3D 0, duplicates =3D 0;
=09int shown =3D 0;
=09size_t i;

=09while (off + sizeof(struct perf_event_header) <=3D c->len) {
=09=09struct perf_event_header hdr;

=09=09memcpy(&hdr, c->buf + off, sizeof(hdr));
=09=09if (hdr.size < sizeof(hdr) || hdr.size > c->len - off)
=09=09=09break;
=09=09if (hdr.type =3D=3D PERF_RECORD_SAMPLE) {
=09=09=09if (hdr.size !=3D sizeof(struct clock_sample))
=09=09=09=09break;
=09=09=09total++;
=09=09=09if (nrec =3D=3D cap) {
=09=09=09=09cap =3D cap ? cap * 2 : 4096;
=09=09=09=09recs =3D realloc(recs, cap * sizeof(*recs));
=09=09=09=09if (!recs)
=09=09=09=09=09die("realloc records");
=09=09=09}
=09=09=09recs[nrec].hash =3D hash_record(c->buf + off, hdr.size);
=09=09=09recs[nrec].off =3D off;
=09=09=09recs[nrec].size =3D hdr.size;
=09=09=09recs[nrec].push =3D push_for_offset(c, off);
=09=09=09nrec++;
=09=09}
=09=09off +=3D hdr.size;
=09}

=09if (off !=3D c->len) {
=09=09fprintf(stderr, "invalid or truncated perf record at byte %zu\n", off=
);
=09=09free(recs);
=09=09return 1;
=09}
=09if (!total) {
=09=09fprintf(stderr, "no cpu-clock samples captured\n");
=09=09free(recs);
=09=09return 1;
=09}

=09qsort_r(recs, nrec, sizeof(*recs), rec_cmp, c->buf);

=09for (i =3D 0; i < nrec; i++) {
=09=09if (!i || rec_cmp(&recs[i - 1], &recs[i], c->buf)) {
=09=09=09unique++;
=09=09=09continue;
=09=09}
=09=09duplicates++;
=09=09if (!shown) {
=09=09=09struct rec *a =3D &recs[i - 1], *b =3D &recs[i];

=09=09=09printf("replay: identical record at %zu (push %lu) and "
=09=09=09       "%zu (push %lu), size=3D%u time=3D%" PRIu64 " memcmp=3D0\n"=
,
=09=09=09       a->off, a->push, b->off, b->push, a->size,
=09=09=09       time_of(c->buf + a->off));
=09=09=09shown =3D 1;
=09=09}
=09}

=09printf("replay: records=3D%lu unique=3D%lu duplicates=3D%lu "
=09       "cursor_mismatches=3D%lu capture_bytes=3D%zu\n",
=09       total, unique, duplicates, cursor_mismatches, c->len);
=09printf("replay: result=3D%s\n",
=09       duplicates || cursor_mismatches ? "FAIL" : "PASS");
=09free(recs);
=09if (fflush(stdout) =3D=3D EOF || ferror(stdout)) {
=09=09fprintf(stderr, "failed to write replay report\n");
=09=09return 1;
=09}
=09return duplicates || cursor_mismatches ? 1 : 0;
}

int main(void)
{
=09struct capture c =3D { 0 };
=09struct mmap md =3D { 0 };
=09int ready[2], go[2];
=09pid_t worker;
=09int fd =3D -1, status, worker_done =3D 0, empty =3D 0, result =3D 1;
=09size_t last =3D 0;
=09unsigned long pushes, cursor_mismatches =3D 0, mismatch_prints =3D 0;
=09int64_t deadline;
=09struct sigaction sa =3D { .sa_handler =3D interrupt_handler };

=09libperf_init(NULL);
=09sigemptyset(&sa.sa_mask);
=09sigaction(SIGINT, &sa, NULL);
=09sigaction(SIGTERM, &sa, NULL);
=09signal(SIGPIPE, SIG_IGN);

=09if (pipe(ready) || pipe(go))
=09=09die("pipe");

=09worker =3D fork();
=09if (worker < 0)
=09=09die("fork");
=09if (!worker) {
=09=09close(ready[0]);
=09=09close(go[1]);
=09=09_exit(worker_main(ready[1], go[0]));
=09}

=09close(ready[1]);
=09close(go[0]);
=09{
=09=09struct pollfd pfd =3D { .fd =3D ready[0], .events =3D POLLIN };
=09=09char byte;

=09=09if (poll(&pfd, 1, 10000) <=3D 0 ||
=09=09    read(ready[0], &byte, 1) !=3D 1 || byte !=3D 'R') {
=09=09=09fprintf(stderr, "worker did not become ready\n");
=09=09=09goto out;
=09=09}
=09}

=09fd =3D open_cpu_clock(worker);
=09if (fd < 0)
=09=09goto out;
=09if (map_ring(fd, &md.core))
=09=09goto out;
=09if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
=09=09perror("ENABLE");
=09=09goto out;
=09}

=09if (write(go[1], "G", 1) !=3D 1) {
=09=09perror("write go");
=09=09goto out;
=09}

=09deadline =3D now_ms() + CAPTURE_TIMEOUT_MS;
=09for (pushes =3D 0; ; pushes++) {
=09=09size_t before =3D c.len;
=09=09uint64_t old_prev =3D md.core.prev;
=09=09int ret;

=09=09c.push =3D pushes;
=09=09ret =3D perf_mmap__push(&md, &c, capture_push);

=09=09if (interrupted) {
=09=09=09fprintf(stderr, "capture interrupted\n");
=09=09=09goto out;
=09=09}
=09=09if (ret < 0) {
=09=09=09fprintf(stderr, "push failed: %d\n", ret);
=09=09=09goto out;
=09=09}
=09=09if (ret =3D=3D 0 && c.len > before && md.core.prev !=3D md.core.end) =
{
=09=09=09cursor_mismatches++;
=09=09=09if (mismatch_prints++ < 5)
=09=09=09=09fprintf(stderr,
=09=09=09=09=09"BUG: push=3D%lu copied=3D[%" PRIu64 ",%" PRIu64
=09=09=09=09=09") saved_prev=3D%" PRIu64
=09=09=09=09=09" replay_bytes=3D%" PRIu64 "\n",
=09=09=09=09=09pushes, old_prev, (uint64_t)md.core.end,
=09=09=09=09=09(uint64_t)md.core.prev,
=09=09=09=09=09(uint64_t)(md.core.end - md.core.prev));
=09=09}
=09=09if ((pushes & 0x3ff) =3D=3D 0) {
=09=09=09int64_t now =3D now_ms();
=09=09=09pid_t pid =3D 0;

=09=09=09if (now < 0 || now >=3D deadline) {
=09=09=09=09fprintf(stderr, "capture timed out\n");
=09=09=09=09goto out;
=09=09=09}
=09=09=09if (!worker_done)
=09=09=09=09pid =3D waitpid(worker, &status, WNOHANG);
=09=09=09if (pid =3D=3D worker) {
=09=09=09=09worker_done =3D 1;
=09=09=09=09if (!WIFEXITED(status) || WEXITSTATUS(status)) {
=09=09=09=09=09fprintf(stderr, "worker failed: %d\n", status);
=09=09=09=09=09goto out;
=09=09=09=09}
=09=09=09} else if (pid < 0 && errno !=3D EINTR) {
=09=09=09=09perror("waitpid worker");
=09=09=09=09goto out;
=09=09=09}
=09=09}
=09=09if (worker_done) {
=09=09=09if (c.len =3D=3D last) {
=09=09=09=09if (++empty > 1000)
=09=09=09=09=09break;
=09=09=09} else {
=09=09=09=09empty =3D 0;
=09=09=09}
=09=09=09last =3D c.len;
=09=09}
=09}

=09if (ioctl(fd, PERF_EVENT_IOC_DISABLE, 0) < 0) {
=09=09perror("DISABLE");
=09=09goto out;
=09}
=09result =3D report(&c, cursor_mismatches);
out:
=09if (!worker_done) {
=09=09kill(worker, SIGKILL);
=09=09while (waitpid(worker, &status, 0) < 0 && errno =3D=3D EINTR)
=09=09=09;
=09}
=09if (md.core.base)
=09=09perf_mmap__munmap(&md.core);
=09if (fd >=3D 0)
=09=09close(fd);
=09close(ready[0]);
=09close(go[1]);
=09free(c.buf);
=09free(c.segs);
=09return result;
}

