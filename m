From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] perf tools: allow map files to specify DSO
Date: Mon, 7 May 2018 11:40:01 -0700
Message-ID: <20180507184001.GE4050@tassilo.jf.intel.com>
References: <1525717456-21475-1-git-send-email-johunt@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525717456-21475-1-git-send-email-johunt@akamai.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Hunt <johunt@akamai.com>
Cc: mingo@redhat.com, acme@kernel.org, peterz@infradead.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, May 07, 2018 at 02:24:16PM -0400, Josh Hunt wrote:
> Add the ability to specify a DSO in the /tmp/perf-<PID>.map file.
> The DSO should be the first line in the file and readable by the
> running user. If a valid DSO is found all other contents of the
> file will be ignored. This allows things like callchain unwinding
> with DWARF to work.

FWIW it's ok, but also obsolete with Kirill's large-pages-in-tmpfs
work in newer kernels. With that you can just copy the executable into
a 2MB tmpfs and disable the manual huge page copying and everything
should work as usually.

So essentially it's only a hack for old kernels and old binaries.

But doesn't hurt I guess.

-Andi
