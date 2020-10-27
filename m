From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: Perf raw sample overflows perf record
Date: Tue, 27 Oct 2020 14:08:53 +0900
Message-ID: <CAM9d7ciF4WoPbiJSCBVpU4p6h92t9+ZEYGvDuMim_kfqUi58Dg@mail.gmail.com>
References: <29be54b5-5872-33ac-7c8e-998d77226a0a@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29be54b5-5872-33ac-7c8e-998d77226a0a@amazon.com>
To: George Prekas <prekageo@amazon.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

+ LKML

On Sat, Oct 24, 2020 at 8:44 AM George Prekas <prekageo@amazon.com> wrote:
>
> The header of a perf sample has a u16 field for the size of the record.
> On the other hand, a PERF_SAMPLE_RAW has a u32 field for its size.
>
> I've written a test perf driver that creates large raw samples and it
> doesn't work correctly (as expected). For example, perf record fails with:
>
> Can't parse sample, err = -14
> 0x4688 [0x8]: failed to process type: 68 [Bad address]
>
> Is this expected? Is the developer of the perf driver responsible to
> make sure that each perf record does not exceed 64KB in size? If that's
> the case, I am wondering why the raw sample has a u32 for its size.

For the large records, you may consider an auxtrace interface.

Thanks
Namhyung
