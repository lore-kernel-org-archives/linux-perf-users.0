From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 2/5] perf/jevents: Add new structure to pass json fields.
Date: Thu, 3 Sep 2020 23:54:54 +0900
Message-ID: <CAM9d7cjDRGDuZhbZ1BJ2tF_hyrS0-b61kaL2=0VHtSFUcJN7sg@mail.gmail.com>
References: <20200902160439.335232-1-kjain@linux.ibm.com> <20200902160439.335232-3-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200902160439.335232-3-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, pc@us.ibm.com, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Yao Jin <yao.jin@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Ian Rogers <irogers@google.com>, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, John Garry <john.garry@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Hello,

On Thu, Sep 3, 2020 at 1:05 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>
> This patch adds new structure called 'json_event' inside jevents.h

jevents.c ?

Thanks
Namhyung

> file to improve the callback prototype inside jevent files.
> Initially, whenever user want to add new field, they need to update
> in all function callback which make it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
